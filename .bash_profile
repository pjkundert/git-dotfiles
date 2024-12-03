# Executed for login shells
#
# Put things in here that you only want to run at login

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi


# Nix integration: run nix-env -irf ~/env.nix
# - NIX_PATH references ~/.nix-defexpr, eg:
#   export NIX_PATH="$HOME/.nix-defexpr"
# - ~/.nix-defexpr/nixpkgs/default.nix references the default Nix version, eg:
#   import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/tags/24.05.tar.gz")
# - Move contents of /etc/bash.bashrc to the end of your ~/.bash_profile,
#   and clear Nix stuff out of /etc/bash.bashrc.  It doesn't belong there (macOS can change it)
# - Ensure you have a /nix/var/nix/profiles/per-user/$USER dir, owned by you and in a writable group eg. staff
# - Backup env.nix, .nix-defexpr  and .bash_profile in eg. git
# - Run: nix-env -irf ~/env.nix to populate your ~/.nix-profile/bin with your env.nix targets!

# Nix integration: run nix-env -irf ~/env.nix
# - NIX_PATH references ~/.nix-defexpr
# - ~/.nix-defexpr contains eg. 
# export NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/refs/tags/24.05.tar.gz
export NIX_PATH="$HOME/.nix-defexpr"

# Nix
if [ -e /Users/perry/.nix-profile/etc/profile.d/nix.sh ]; then 
  . /Users/perry/.nix-profile/etc/profile.d/nix.sh; 
fi # added by Nix installer

# Setting PATH for Python 3.10
# - Needed to build SLIP-39.app/pkg/dmg
# The original version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
export PATH

# COLORTERM=truecolor wrecks GNU emacs in screen, at least on macOS
unset COLORTERM

# Rust/Cargo development integration
#export PATH="$HOME/src/holochain-rust/.cargo/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix