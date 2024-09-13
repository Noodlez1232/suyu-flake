{ pkgs, nx_tzdb, ... }:
let
  version = "v0.0.3";
  src = pkgs.fetchFromGitea {
    domain = "git.suyu.dev";
    owner = "suyu";
    repo = "suyu";
    rev = version;
    hash = "sha256-wLUPNRDR22m34OcUSB1xHd+pT7/wx0pHYAZj6LnEN4g=";
    fetchSubmodules = true;
  };
  
in
pkgs.callPackage ./suyu.nix (pkgs.kdePackages // { inherit nx_tzdb version src; pname = "suyu"; })
