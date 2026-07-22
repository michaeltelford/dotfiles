---
name: skill-repo-audit
description: Read-only, repo-wide audit for a given analysis type (performance, security, bugs, etc.). Use when the user asks to look over an entire repository and report findings without changing anything. Takes two arguments - the repo (path or name) and the analysis type.
argument-hint: <repo-path-or-name> <performance|security|bugs|quality|dependencies>
---

# Repo Audit

Perform a READ-ONLY audit of an entire repository and report ranked findings. Make **no changes** to the repo — the deliverable is the report.

## Arguments

- `$1` — the repository to audit. If it's an absolute path, use it directly. If it's a bare name (e.g. `job-manager`), resolve it: check the current working directory first, then sibling directories of the CWD (e.g. `../$1`), then common dev roots (e.g. `~/Development/**/$1`). If it cannot be found, ask the user for the path.
- `$2` — the analysis type: `performance`, `security`, `bugs`, `quality`, `dependencies`, or another the user names. If omitted, ask which analysis to run.

## Workflow

0. **Start afresh — never reuse past audits.** Every invocation is a full, independent audit, even if this repo (or this same analysis type) was audited earlier in the conversation. Do not skip the survey, reuse earlier agent findings, or carry over verification reads from a previous run — the repo may have changed and stale results defeat the purpose. Re-survey, re-launch agents, and re-verify from scratch every time, even though this uses more tokens. Prior audits may be referenced only to cross-link related findings in the final report (e.g. "overlaps with security finding H1"), never as a source of findings or as a reason to skip work.

1. **Survey the repo** (one quick pass): list files (excluding `node_modules`, `vendor`, `.git`, `dist`, build output, generated mocks), identify the language(s), framework, entry points, and rough layout. Use this to decide how to split the exploration.

2. **Fan out 2–3 Explore agents in parallel** (single message, multiple tool calls), each with:
   - A distinct slice of the codebase (e.g. data/persistence layer; external I/O + core logic; entry point/config/build/CI).
   - The analysis-type checklist below, embedded in the prompt.
   - Instructions to report: file path + line numbers, a short code excerpt, why it's an issue, and the easy fix; rank by impact; explicitly say which checklist categories had **no** findings.
   - The constraint that findings must be actionable and low-risk (for performance: behavior-preserving; for security: no speculative findings without a concrete scenario).

3. **Verify before reporting**: read the exact lines of every high/medium finding yourself to confirm the agents' claims. Drop or downgrade anything that doesn't hold up (e.g. a "new client per call" that actually reuses a pooled default transport is a smaller finding than claimed).

4. **Report** in the final message, leading with the answer (are there wins/issues or not), then findings ranked high → medium → low, each with `file:line` references. Include:
   - A short "already done right" section (things checked that were fine) — this is as valuable as the findings.
   - A "deliberately excluded" section for changes that would alter behavior or live outside the repo (vendored/shared libs).
   - If in plan mode or asked for a plan, also write the findings as an ordered, behavior-preserving change plan with a verification section (build, unit tests, integration tests).

## Analysis-type checklists

Embed the relevant checklist in each Explore agent's prompt, adapted to the repo's language.

### performance
Easy wins only — no logic/behavior changes:
- HTTP clients/transports, DB connections, API/gRPC/SDK clients constructed per-call instead of reused (loses pooling/keep-alives).
- Response bodies not closed or drained (breaks connection reuse and leaks fds), especially on error paths before a `defer`.
- Regex compilation, template parsing, or other expensive setup inside per-request functions instead of package/module level.
- DB queries inside loops (N+1) where a batch query exists; repeated identical queries in one request.
- Missing connection-pool tuning (max open/idle conns, lifetimes) — note if it lives in an external lib.
- String building with `+=` in loops; `fmt.Sprintf`/f-string overhead in hot loops only.
- Collections grown by append/push in per-request loops over known-length inputs without capacity hints.
- Marshal/unmarshal round-trips used just to copy/convert structs; reading whole bodies where streaming decode works.
- Sequential independent I/O that could run concurrently — flag as "maybe" only; concurrency changes semantics.
- Config parsed or clients built per request instead of at startup.
- Build/CI (separate section, dev-experience not runtime): Docker layer caching / cache mounts, dependency-layer split, CI caching, language-version upgrade for free runtime gains.

### security
- Secrets/credentials/tokens hardcoded, logged, or committed (also check sample configs, test fixtures, CI files).
- Injection: SQL built by string concatenation/interpolation, shell command construction from input, path traversal on user-supplied paths.
- AuthN/AuthZ: endpoints missing auth middleware/interceptors, missing tenant/organization scoping on queries (IDOR), trust of client-supplied IDs.
- Sensitive data in logs (auth headers, full request dumps, PII), overly verbose error messages leaking internals.
- TLS/verification disabled, insecure defaults, outdated crypto primitives.
- Dependency CVEs: report versions of key deps and flag known-vulnerable ranges.
- Unvalidated redirects/URLs fetched from user input (SSRF), unsafe deserialization.
- File permissions, temp-file handling, unsafe YAML/pickle-style loading (language-dependent).

### bugs
- Error paths: swallowed errors, missing error checks, resources not closed on early returns, deferred cleanup registered after early returns.
- Nil/None/undefined dereferences guarded inconsistently; unchecked type assertions/casts.
- Concurrency: shared state without locks, goroutine/promise leaks, misuse of loop variables in closures, race-prone lazy init.
- Off-by-one, boundary conditions, slicing/truncation on multibyte strings.
- Contexts/timeouts not propagated; retries without backoff; deadlock-prone lock ordering.
- Inconsistent behavior between near-duplicate code paths (e.g. two handlers where one has a fix the other lacks).

### quality
- Dead code, unused exports, duplicated logic that an existing utility already covers.
- Over-complex functions that reduce to existing stdlib/framework calls; wrong-altitude abstractions.
- Inconsistent patterns across the codebase (error wrapping, logging, naming) — report the dominant pattern and the stragglers.
- Test gaps for critical paths (note only; don't demand full coverage).

### dependencies
- Outdated language/runtime version vs current stable, and what upgrading buys.
- Major-version-behind or unmaintained dependencies; duplicated dependencies serving the same purpose.
- Sub-modules/workspaces with drifting versions of the same dep.
- Vendored code that masks upstream fixes.

For any other analysis type the user names, derive a comparable checklist of concrete, greppable patterns before launching agents.

## Rules

- Every run is from scratch: no reusing findings, surveys, or file reads from earlier audits in the conversation (see Workflow step 0).
- READ-ONLY throughout: no edits, no formatters, no dependency installs. Running build/test commands is allowed only if needed to verify a finding and they don't mutate the tree.
- Every finding must cite `file:line` and survive your own verification read. Never report an agent finding you did not spot-check (high/medium ones at minimum).
- Prefer fewer, verified findings over long speculative lists.
