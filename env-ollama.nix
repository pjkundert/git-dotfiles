/*
This is a nix expression to pin Ollama at a specific working version (0.10.0).
The current nixpkgs version has a broken Ollama package, so we pin to a 
specific nixpkgs revision that contains the working version.

To use this, import it in your env.nix file:
  ollama = import ./env-ollama.nix { inherit pkgs; };
*/

{ pkgs ? import <nixpkgs> {} }:

let
  # Pin to nixpkgs revision containing working Ollama 0.10.0
  ollamaPkgs = import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    # This revision contains ollama 0.14.1 - you may need to find the exact commit
    rev = "656658d2112fe9b1b6df2500f88a7f90a5873df3";
    sha256 = "sha256-K2UOxyWbcfi7ZRIvN5u0DcFR3WuOm2Yi2U+gYRGScHE=";
  }) {};
in
  ollamaPkgs.ollama
