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
  tex # texlive.combined.scheme-full  # incl. pdflatex, wrapfig.sty, ...
  ispell

  # Development tools
  cacert
  git
  gnumake
  jq
  openssh
  screen

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

  # Project tools
  socat
]
