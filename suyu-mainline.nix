{ pkgs, nx_tzdb, ... }:
let
  version = "unstable-2024-04-17";
  src = pkgs.fetchFromGitea {
    domain = "git.suyu.dev";
    owner = "suyu";
    repo = "suyu";
    rev = "daf2c1f49658ebe88d9038baf35d4e3c3703a454";
    hash = "sha256-hQfb6cVSSKiw79RxerKJis1OTS6J/wEaIFg4h/R416M=";
    fetchSubmodules = true;
  };
  
in
pkgs.callPackage ./suyu.nix (pkgs.kdePackages // { inherit nx_tzdb version src; pname = "suyu"; })
