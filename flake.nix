{
  description = "LSP implementation for Neorg's .norg file format";
  inputs.nixpkgs.url = github:nixos/nixpkgs?ref=nixos-22.11;

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    genSystems = nixpkgs.lib.genAttrs supportedSystems;
    pkgs = genSystems (system: import nixpkgs {inherit system;});
  in {
    packages = genSystems (system: rec {
      norg-ls = pkgs.${system}.callPackage ./. {};
      default = norg-ls;
    });

    formatter = genSystems (system: pkgs.${system}.alejandra);
  };
}
