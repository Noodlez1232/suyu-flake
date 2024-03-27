{ pkgs, nx_tzdb, ... }:
let
  version = "unstable-2024-03-27";
  src = pkgs.fetchFromGitea {
    domain = "git.suyu.dev";
    owner = "suyu";
    repo = "suyu";
    rev = "09578d522b203458d8196001bc5130de8c4e619a";
    hash = "sha256-OkzDzgons8jOW4NkO6YwzkqwiPJ3GfeTJyB9ZLuaEE0=";
    fetchSubmodules = true;
  };
  
in
pkgs.callPackage ./suyu.nix { inherit nx_tzdb version src; pname = "suyu"; }
