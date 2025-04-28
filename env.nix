let
  pkgs = import <nixpkgs> {};
  emacs = import ./emacs.nix { inherit pkgs; };
  uemacs = import ./uemacs.nix { inherit pkgs; };
  #tex = (pkgs.texlive.combine {
  #  inherit (pkgs.texlive) scheme-basic
  #  ;
  #});
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
  uemacs
  emacs
  ispell
  #codeium       # codeium_server_process for Emacs codeium bindings

  # Emacs PDF generation dependencies
  #mermaid-cli   # Requires nodejs
  #ditaa jdk     # Requires nodejs and java
  #tex           # Huge! Use for PDF export in emacs # incl. pdflatex, wrapfig.sty, ...

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

  # Javascript tools
  #nodejs	# Javascript development

  # AI
  ollama	# eg. Run in 2 terminals: $ ollama serve, $ ollama run deepseek-r1:8b

  # Python 3 support
  python
  (with pythonPackages; [
    pytest
    tkinter
    ipython
    ipykernel
    #jupyter_core
    #jupyter_client
    #jupyterlab
    numpy
    scipy
    scikitlearn
    pip
    pyzmq
    matplotlib
  ])
]
