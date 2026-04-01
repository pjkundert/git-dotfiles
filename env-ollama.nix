/*
Pin Ollama and llama-cpp to a specific nixpkgs revision.

To use this, import it in your env.nix file:
  llamas = import ./env-ollama.nix { inherit pkgs; };
*/

{ pkgs ? import <nixpkgs> {} }:

let
  # nixpkgs-unstable 2026-03-23: ollama 0.18.2
  ollamaPkgs = import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "fdc7b8f7b30fdbedec91b71ed82f36e1637483ed";
    sha256 = "sha256-a++tZ1RQsDb1I0NHrFwdGuRlR5TORvCEUksM459wKUA=";
  }) {};

in [
  ollamaPkgs.ollama
  ollamaPkgs.llama-cpp
]
