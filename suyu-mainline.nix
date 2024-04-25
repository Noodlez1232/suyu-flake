{ pkgs, nx_tzdb, ... }:
let
  version = "unstable-2024-04-17";
  src = pkgs.fetchFromGitea {
    domain = "git.suyu.dev";
    owner = "suyu";
    repo = "suyu";
    rev = "dfb9f06e5c46f251e4208adf1d4861e85b1d5eea";
    hash = "sha256-Jycpnfnx71alnxu+KgnOvaO26diEspx3O1dhA9OGflI=";
    fetchSubmodules = true;
  };
  
in
pkgs.callPackage ./suyu.nix { inherit nx_tzdb version src; pname = "suyu"; }
