{
  description = "Neovim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{flake-parts, ... }: 
    flake-parts.lib.mkFlake { inherit inputs; } (top@{ config, withSystem, moduleWithSystem, ... }: {
      imports = [ ];
      flake = { };
      systems = [
        "x86_64-linux"
      ];
      perSystem = { config, pkgs, ... }: {
        packages.default = pkgs.callPackage ./neovim.nix { inherit pkgs; };
      };
    });
}
