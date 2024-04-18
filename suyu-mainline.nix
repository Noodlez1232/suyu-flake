{ pkgs, nx_tzdb, ... }:
let
  version = "unstable-2024-04-17";
  src = pkgs.fetchFromGitea {
    domain = "git.suyu.dev";
    owner = "suyu";
    repo = "suyu";
    rev = "3f76206e9bba0fbb86f62c7a3494bd2f985e8524";
    hash = "sha256-TFLKhkIT4vnRAzPDZDuO2F7ifmBGTS9eD+WxRCct8l8=";
    fetchSubmodules = true;
  };
  
in
pkgs.callPackage ./suyu.nix { inherit nx_tzdb version src; pname = "suyu"; }
