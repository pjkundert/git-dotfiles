let
  pkgs = import <nixpkgs> {};
  customEmacs = import ./emacs.nix { inherit pkgs; };
in with pkgs; [  
  # Editors
  customEmacs
  ispell

  # Development tools
  cacert
  git
  gnumake
  jq
  openssh
  screen

  # Python 3 default
  python312Full
  python312Packages.pytest
  python312Packages.tkinter
  python312Packages.jupyterlab
  python312Packages.numpy
  python312Packages.scipy
  python312Packages.scikitlearn
]
