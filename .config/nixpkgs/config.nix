{
  # Should set these in flake.nix, eg:
  # outputs = { self, nixpkgs }:
  #   let
  #     forAllSystems = nixpkgs.lib.genAttrs [
  #       "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"
  #     ];
  #   in {
  #     devShells = forAllSystems (system:
  #       let
  #         pkgs = import nixpkgs {
  #           inherit system;
  #           config = {
  #             allowUnfree = true;
  #             allowUnsupportedSystem = true;
  #             permittedInsecurePackages = [
  #               "python-2.7.18.12"
  #               "python-2.7.18.12-env"
  #             ];
  #           };
  #         };
  # ...
  #
  # Rather then here, eg:
  # allowUnfree = true;
  # allowUnsupportedSystem = true;
  # permittedInsecurePackages = [
  #   "python-2.7.18.12"
  #   "python-2.7.18.12-env"
  #   "python2.7-virtualenv-20.33.1"
  #   "python2.7-platformdirs-4.5.0"
  #   "python3.12-ecdsa-0.19.1"
  #   "python3.13-ecdsa-0.19.1"
  # ];

  # However, for updating Nix-supplied global ~/env.nix environment using:
  #
  #     nix-env -irf $HOME/env.nix
  #
  # which contains unfree resources, we need this here:
  allowUnfree = true;
  permittedInsecurePackages = [
     "python3.12-ecdsa-0.19.1"
     "python3.13-ecdsa-0.19.1"
  ];
}
