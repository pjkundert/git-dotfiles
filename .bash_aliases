alias gs="git status"
alias l="ls -la"
alias lh='ls -last|head'
alias glog="git log --all --graph --decorate"
alias sha256='python3 -c "import sys, hashlib, base64; [print(base64.b64encode(hashlib.sha256(open(f, \"rb\").read()).digest()).decode(), f) for f in sys.argv[1:]]"'
alias git-dotfiles='git --git-dir=$HOME/.git-dotfiles --work-tree=$HOME'
alias git.=git-dotfiles
alias nix-env-update='nix-env -irf $HOME/env.nix'
alias nix-env.=nix-env-update
