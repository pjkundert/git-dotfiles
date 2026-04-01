/*
Pin Ollama and llama-cpp to a specific nixpkgs revision.

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

in [
  ollamaPkgs.ollama
  ollamaPkgs.llama-cpp
]
