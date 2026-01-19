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

export BASH_SILENCE_DEPRECATION_WARNING=1

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
# export NIX_PATH="$HOME/.nix-defexpr"
export NIX_PATH="$HOME/.nix-defexpr/channels/nixpkgs"

export PATH

# COLORTERM=truecolor wrecks GNU emacs in screen, at least on macOS
unset COLORTERM

# Add the default xcode command-line stuff; early, so overridden by anything Nix-supplied
XCODE_PATH=$(xcode-select -p)
if [ -n "${XCODE_PATH}" ]; then
    export PATH="${XCODE_PATH}/usr/bin:$PATH"
fi

# Setting PATH for Python 3.13
# The original version is saved in .bash_profile.pysave
export PATH="/Library/Frameworks/Python.framework/Versions/3.13/bin:${PATH}"


# Rust/Cargo development integration
export PATH="$HOME/.cargo/bin:$PATH"

# Add Docker CLI if installed (Docker Desktop on macOS is unreliable at providing $HOME/.docker/bin)
if [[ -d "/Applications/Docker.app/Contents/Resources" ]]; then 
    export PATH="/Applications/Docker.app/Contents/Resources/bin/:/Applications/Docker.app/Contents/Resources/cli-plugins/:$PATH";
fi

# Support Nix in multi-user and (optionally) individual installations
for script in "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" \
              "$HOME/.nix-profile/etc/profile.d/nix.sh"; do
    if [ -f "$script" ]; then
	. "$script"
	break
    fi
done

# If we're running a version of bash capable of it, use bash-completions.  Otherwise, prompt
# to change shell to Nix environment supplied version.
if [[ -z "${BASH_VERSION%%5*}" && -r "$HOME/.nix-profile/share/bash-completion/bash_completion" ]]; then
    . $HOME/.nix-profile/share/bash-completion/bash_completion
else
    echo "Not loading bash-completions; chsh -s $HOME/.nix-profile/bin/bash # (add to /etc/shell first)"
fi

# Nix
#if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then 
#  . $HOME/.nix-profile/etc/profile.d/nix.sh; 
#fi # added by Nix installer

# Node development path for npm install -g ... installations
export PATH=$HOME/.node_global/bin:$PATH

# Puppeteer/mermaid-cli: Use chromium from Nix profile
export PUPPETEER_EXECUTABLE_PATH=$HOME/.nix-profile/bin/google-chrome-stable
