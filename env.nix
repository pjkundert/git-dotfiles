let
  pkgs = import <nixpkgs> {};
  emacs = import ./env-emacs.nix { inherit pkgs; };
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full
      dvisvgm dvipng # for preview and export as html
      wrapfig wrapfig2 amsmath ulem hyperref capt-of;
      #(setq org-latex-compiler "lualatex")
      #(setq org-preview-latex-default-process 'dvisvgm)
  });
  python = pkgs.python312Full;
  pythonPackages = pkgs.python312Packages;
in with pkgs; [  
  # Editors and basic dependencies
  bash
  bash-completion
  uemacs
  emacs
  ispell
  #codeium       # codeium_server_process for Emacs codeium bindings

  # Emacs PDF generation dependencies
  mermaid-cli   # Requires nodejs
  ditaa jdk     # Requires nodejs and java
  tex           # Huge! Use for PDF export in emacs # incl. pdflatex, wrapfig.sty, ...

  # Development tools
  cacert
  git # git-filter-repo
  gnumake
  cmake
  jq
  openssh
  screen
  multitail
  pstree

  # Project tools
  socat		# for RS-485 serial I/O testing
  hugo		# for static website generation
  rustup	# cargo, etc.
  gh		# Github CLI interface
  wget
  diffutils	# GNU diff, etc.
  wakeonlan
  cloudflared

  # Javascript tools
  nodejs	# Javascript development

  # C# Tools, QUIC protocol implementation
  dotnet-sdk_8
  powershell
  libmsquic

  # AI
  ollama	# eg. Run in 2 terminals: $ ollama serve, $ ollama run deepseek-r1:8b

  # Python 3 support
  python
  (with pythonPackages; [
    ipykernel
    ipython
    jupyter_client
    jupyter_core
    jupyterlab
    matplotlib
    numpy
    pip
    pytest
    pyzmq
    scikitlearn
    scipy
    tkinter
    trezor
  ])
]
