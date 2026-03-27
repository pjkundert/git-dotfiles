let
  pkgs = import <nixpkgs> {};
  emacs = import ./env-emacs.nix { inherit pkgs; };
  llamas = import ./env-ollama.nix { inherit pkgs; };
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full
      dvisvgm dvipng # for preview and export as html
      wrapfig wrapfig2 amsmath ulem hyperref capt-of;
      #(setq org-latex-compiler "lualatex")
      #(setq org-preview-latex-default-process 'dvisvgm)
  });

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
  google-chrome # chromium      # Required by mermaid-cli for rendering diagrams
  ditaa jdk     # Requires nodejs and java
  tex pandoc    # Huge! Use for PDF export in emacs # incl. pdflatex, wrapfig.sty, ...

  # Development tools
  cacert
  git
  #gitSVN subversion svn2git
  git-credential-manager # git-filter-repo
  gnumake
  cmake
  jq yq
  openssh
  screen
  multitail
  pstree

  # Project tools
  socat         # for RS-485 serial I/O testing
  hugo go       # for static website generation
  rustup        # cargo, etc.
  gh            # Github CLI interface
  wget
  diffutils     # GNU diff, etc.
  wakeonlan
  cloudflared

  # Image manipulation
  imagemagick   # for image conversion (SVG to PNG, etc.)
  poppler_utils # pdftoppm — PDF page rendering (used by Claude Code)
  poppler
  ffmpeg
  ghostscript

  # Javascript tools; Claude code, etc.
  nodejs_20     # Not a bleeding-edge version
  ripgrep

  # C# Tools, QUIC protocol implementation.  Fragile...
  #dotnet-sdk_8
  #powershell
  #libmsquic

  # Python 3 support
  uv
  (python3.withPackages (ps: with ps; [
    ipykernel
    ipython
    # jupyter_client
    # jupyter_core
    # jupyterlab
    markdown
    matplotlib
    plotly
    numpy
    pandas
    pip
    pytest
    pyzmq
    scikit-learn
    scipy
    pillow
    tabulate
    tkinter
    trezor
    pyyaml
    faster-whisper  # Local speech-to-text with word-level timestamps (CTranslate2)
  ]))
] ++ llamas  # ollama, llama-cpp
