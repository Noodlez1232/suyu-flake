{ pkgs, nx_tzdb, ... }:
let
  version = "unstable-2024-04-17";
  src = pkgs.fetchFromGitea {
    domain = "git.suyu.dev";
    owner = "suyu";
    repo = "suyu";
    rev = "93b7854f957cae3697ccf506533f87d9adbceb65";
    hash = "sha256-xyyJgfJVZEnkk5nbw6Zg/mqI1oZdRr5uBtM+JKCX1Pc=";
    fetchSubmodules = true;
  };
  
in
pkgs.callPackage ./suyu.nix { inherit nx_tzdb version src; pname = "suyu"; }
