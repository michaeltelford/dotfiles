
# Dotfiles

Quick setup of an awesome development environment on any *nix machine. Boom!

## Includes

- Homebrew (or Linuxbrew) packages
- Bash customisations (aliases, functions, git prompt etc.)
- Ruby interpreters and gems
- ...

## Dependancies

If on OS X then the below should already be installed, otherwise if on linux
use the native package manager to install these packages first. 

- bash
- curl
- ruby
- git (for Linux distros only, not OS X)

## Fork and Extend

Feel free to fork the repository and extend (or trim) it to your liking by:

- Add a new topic folder e.g. `python`.
- In it create an `install.sh` script which is executable.  This script will 
be run automatically by `./bootstrap.sh`. 
- If you need a file symlinked from your topic folder to the home directory,
simply give it the extension `symlink` (see Extension Notes below). 

Pull requests are also welcome but I can't garantee I'll get round to looking 
at them in a timely fashion. 

### Extension Notes

If you want to install a new homebrew package e.g. node then simply add it to 
the `./homebrew/Brewfile`. Done. But if you then want additional configuration 
e.g. to install npm packages once installed then you should also create a 
topic directory (described in'Fork and Extend' above) which handles specific 
configuration, in this case installing npm packages. The brew install always 
completes before topic installers ensuring that any installed executables are 
available as needed. 

Any file following `./bash/*.symlink` will be symlinked to the home directory.
E.g. `.bashrc ~> ./bash/bashrc.symlink` - End `ls -a` result output. 

See `./install_helpers.sh` for useful methods which may make development 
easier e.g. fancy print methods in keeping with existing formatting. 

The scripts are designed so that they can be safely executed multiple times 
on the same environment if necessary. You should ensure that any new 
functionality follows the same pattern when writing an `install.sh` script. 

These dotfiles should be able to run on any *nix distro but is mainly meant 
for Mac OS X machines. Provided is a `./Dockerfile` for testing new changes 
on a debian machine. 

The main `./boostrap.sh` script is designed to fail on an error from another 
script by default. If you want to ignore such failures from a script or 
command then you should append its command with `|| true`. For example, 
`source myscript.sh || true`. This will mask any errors and allow the install 
process to continue. 

## Thanks

...

