/*
Pin Ollama and llama-cpp to a specific nixpkgs revision.
Includes libmlxc.dylib extracted from the official Ollama macOS release,
placed where Ollama's dynamic loader can find it via OLLAMA_LIBRARY_PATH.

To use this, import it in your env.nix file:
  llamas = import ./env-ollama.nix { inherit pkgs; };
*/

{ pkgs ? import <nixpkgs> {} }:

let
  # nixpkgs-unstable 2026-04-01: ollama 0.19.0
  ollamaPkgs = import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "e689fae0005c3b3cc44228ef166960b78d1a8525";
    sha256 = "sha256-JHJ15Bk8abFDHJg/ceqRd9mF1u2/C6USEBUsiXKGyeE=";
  }) {};

  # Extract MLX libraries from the official Ollama macOS release.
  # The Nix sandbox cannot build MLX with Metal support (requires closed-source
  # metal compiler), so we fetch the pre-built dylibs from the official release.
  ollamaMlxLibs = pkgs.stdenvNoCC.mkDerivation {
    pname = "ollama-mlx-libs";
    version = "0.19.0";

    src = pkgs.fetchurl {
      url = "https://github.com/ollama/ollama/releases/download/v0.19.0/ollama-darwin.tgz";
      sha256 = "sha256-UHyMbmuF+hqd0rCOLsOB4Pkvodvh0i9J8egSL/MMwvk=";
    };

    # Tarball extracts flat (no subdirectory), so tell Nix the source root is "."
    sourceRoot = ".";
    dontBuild = true;

    installPhase = ''
      mkdir -p $out/lib/ollama
      cp libmlx.dylib  $out/lib/ollama/
      cp libmlxc.dylib $out/lib/ollama/
      cp mlx.metallib  $out/lib/ollama/
    '';
  };

in {
  packages = [
    ollamaPkgs.ollama
    ollamaPkgs.llama-cpp
    ollamaMlxLibs
  ];
  # Set in your shell or shellHook:
  #   export OLLAMA_LIBRARY_PATH=${ollamaMlxLibs}/lib/ollama
  mlxLibPath = "${ollamaMlxLibs}/lib/ollama";
}
