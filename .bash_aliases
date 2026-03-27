alias l="ls -la"
alias lh='ls -last'
alias glog="git log --all --graph --decorate"
alias sha256='python3 -c "import sys, hashlib, base64; [print(base64.b64encode(hashlib.sha256(open(f, \"rb\").read()).digest()).decode(), f) for f in sys.argv[1:]]"'

# git-dotfiles Nix-based environment management
alias git-dotfiles='git --git-dir=$HOME/.git-dotfiles --work-tree=$HOME'
alias git.=git-dotfiles
alias nix-env-update='nix-env -irf $HOME/env.nix'
alias nix-env.=nix-env-update

# Unpack JSON that contains "script" attributes, and display their path and raw value(s)
alias jqscript='jq -r '\''. as $root | path(.. | objects | select(has("script"))) as $p | ($p + ["script"]) as $sp | ($sp | map(tostring) | join(".")) + ":\n" + ($root | getpath($sp)) + "\n---"'\'''

# Start a 3-bit quantized Qwen3-Coder-Next, and attach claude code to it
alias llama-qwen3-coder-next='llama-server --model /Users/perry/Library/Caches/llama.cpp/unsloth_Qwen3-Coder-Next-GGUF_Qwen3-Coder-Next-UD-Q3_K_XL.gguf --alias unsloth/Qwen3-Coder-Next  --ctx-size 65536  --temp 1.0 --top-p 0.95 --min-p 0.01 --top-k 40 --port 8000 --jinja --cache-type-k q8_0 --cache-type-v q8_0 --flash-attn on'
alias claude-qwen3-coder-next='ANTHROPIC_BASE_URL=http://localhost:8000 ANTHROPIC_API_KEY="" CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1 claude --model Qwen3-Coder-Next'
