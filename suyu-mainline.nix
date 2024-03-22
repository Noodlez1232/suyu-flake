{ pkgs, nx_tzdb, ... }:
let
  version = "unstable-2024-03-22";
  src = pkgs.fetchFromGitea {
    domain = "git.suyu.dev";
    owner = "suyu";
    repo = "suyu";
    rev = "286902ac8a092e5477828ae1ab94b728c347cbbf";
    hash = "sha256-gXRuGGkL8Xa1B8ZmZIN2essbrbAocgkbtchth8WcZc4=";
    fetchSubmodules = true;
  };
  
in
pkgs.callPackage ./suyu.nix { inherit nx_tzdb version src; pname = "suyu"; }
