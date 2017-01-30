
# Dotfiles

Quick setup of an awesome development environment on any *nix machine. Boom!

## Includes

- Bash customisations (aliases, functions, git prompt etc.)
- Homebrew (or Linuxbrew) packages
- Ruby interpreters and gems
- ...

## Dependancies

If on OS X then the below should already be installed, otherwise if on linux
use the native package manager to install these packages first. 

Also the below won't be necessary if you're only installing the dotfile symlinks. 

- bash
- gawk
- curl
- ruby
- git

## Usage

To install on your own machine:

```shell
git clone https://github.com/michaeltelford/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make install # or 'make dotfiles' for symlinks only.
```

Be sure to see the `make help` for what gets installed. Instead of installing 
everything with `make install` you can choose individual components. For 
example running `make dotfiles` will only install the symlinks e.g. .bashrc to 
your home folder. 

You will likely need to restart any existing shell sessions for changes to 
take effect. 

## Fork and Extend

Feel free to fork the repository and extend (or trim) it to your liking by:

- Add a new topic folder e.g. `python`.
- In it create an `install.sh` script which is executable.  This script will 
be run automatically by `make install` or one of the topic make tasks. 
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
easier e.g. fancy print methods in keeping with existing formatting. Also 
see `./Makefile` for install tasks. 

The scripts are designed so that they can be safely executed multiple times 
on the same environment if necessary. You should ensure that any new 
functionality follows the same pattern when writing an `install.sh` script. 

These dotfiles should be able to run on any *nix distro but is mainly meant 
for Mac OS X machines. Provided is a `./Dockerfile` for testing new changes 
on a debian machine. 

The installer scripts are designed to fail on an error by default. If you 
want to ignore such failures from a script or command then you should append 
its command with ` || true`. For example, `source myscript.sh || true`. 
This will mask any errors and allow the install process to continue. 

## Thanks

Thanks must go to: 

- Pete McConnell's [Dotfiles](https://github.com/pemcconnell/.dotfiles) for providing much of the initial bash and docker functionality. 
- Lars Kappert's [tutorial](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.ecldsw9d9) on dotfiles development in general. 
- Zach Holman's [dotfiles](https://github.com/holman/dotfiles) for the approach of easily extending a dotfile repository. Also see his cool [article](https://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/) on dotfiles. 
