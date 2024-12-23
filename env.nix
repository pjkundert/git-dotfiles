let
  pkgs = import <nixpkgs> {};
  emacs = import ./emacs.nix { inherit pkgs; };
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
  # Editors
  emacs
  tex # Huge... texlive.combined.scheme-full  # incl. pdflatex, wrapfig.sty, ...
  mermaid-cli
  ditaa jdk
  ispell

  # Development tools
  cacert
  git
  gnumake
  jq
  openssh
  screen
  multitail

  # Project tools
  socat		# for RS-485 serial I/O testing
  hugo		# for static website generation
  rustup	# cargo, etc.
  nodejs	# Javascript development
  gh		# Github CLI interface

  # Python 3 support
  python
  (with pythonPackages; [
    pytest
    tkinter
    ipython
    ipykernel
    jupyter_core
    jupyter_client
    jupyterlab
    numpy
    scipy
    scikitlearn
    pip
    pyzmq
    matplotlib
  ])
]
