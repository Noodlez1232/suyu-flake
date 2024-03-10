# Suyu emulator, wrapped in a flake
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, flake-utils, ...}@inputs: 
  flake-utils.lib.eachSystem (with flake-utils.lib.system; [
    x86_64-linux
    aarch64-linux
  ])
  (system:
  let
    pkgs = import nixpkgs { inherit system; };
  in
  {
    packages = {
      nx_tzdb = pkgs.callPackage ./nx_tzdb.nix { };
      suyu = pkgs.callPackage ./suyu.nix { nx_tzdb = self.packages.${system}.nx_tzdb; };
      default = self.packages.${system}.suyu;
    };
  });
}
