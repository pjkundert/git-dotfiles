with import <nixpkgs> {}; [
  # Development tools
  emacs
  ispell
  gnumake
  screen
  jq

  # Python 3 default
  python312Full
  python312Packages.pytest
  python312Packages.tkinter
]
