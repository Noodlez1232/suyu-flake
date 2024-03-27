{ pkgs, nx_tzdb, ... }:
let
  version = "v0.0.1";
  src = pkgs.fetchFromGitea {
    domain = "git.suyu.dev";
    owner = "suyu";
    repo = "suyu";
    rev = version;
    hash = "sha256-5AO3Ls0/UbUmJ1haweW9hYDta/0Ad7BL+XlMW/Hz870=";
    fetchSubmodules = true;
  };
  
in
pkgs.callPackage ./suyu.nix { inherit nx_tzdb version src; pname = "suyu"; }
