{ pkgs, nx_tzdb, ... }:
let
  version = "v0.0.2-master";
  src = pkgs.fetchFromGitea {
    domain = "git.suyu.dev";
    owner = "suyu";
    repo = "suyu";
    rev = "v0.0.2-master";
    hash = "sha256-8rureBvjqt2q7HUC2nU0/P8G68UQ1l1X+5mXRRfk990=";
    fetchSubmodules = true;
  };
  
in
pkgs.callPackage ./suyu.nix { inherit nx_tzdb version src; pname = "suyu"; }
