/*
Pin Ollama and llama-cpp to a specific nixpkgs revision.

To use this, import it in your env.nix file:
  llamas = import ./env-ollama.nix { inherit pkgs; };
*/

{ pkgs ? import <nixpkgs> {} }:

let
  # nixpkgs-unstable 2026-03-05: ollama 0.17.4
  ollamaPkgs = import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "917fec990948658ef1ccd07cef2a1ef060786846";
    sha256 = "sha256-au/m3+EuBLoSzWUCb64a/MZq6QUtOV8oC0D9tY2scPQ=";
  }) {};

in [
  ollamaPkgs.ollama
  ollamaPkgs.llama-cpp
]
