# Executed for login shells
#
# Put things in here that you only want to run at login
umask 002
ulimit -n 25000

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
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

export PATH

# COLORTERM=truecolor wrecks GNU emacs in screen, at least on macOS
unset COLORTERM

# Rust/Cargo development integration
export PATH="$HOME/.cargo/bin:$PATH"

# Support Nix in multi-user and (optionally) individual installations
for script in "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" \
              "$HOME/.nix-profile/etc/profile.d/nix.sh"; do
    if [ -f "$script" ]; then
	. "$script"
	break
    fi
done

# Nix
#if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then 
#  . $HOME/.nix-profile/etc/profile.d/nix.sh; 
#fi # added by Nix installer
