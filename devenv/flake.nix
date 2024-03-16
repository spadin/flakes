{
  description = "My development environment, someday";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixvim.url = "github:spadin/flakes?ref=main&dir=nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    tmux.url = "github:spadin/flakes?ref=main&dir=tmux";
    tmux.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    nixvim,
    flake-parts,
    ...
  } @ inputs:
  flake-parts.lib.mkFlake { inherit inputs; } {
    debug = true;

    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    perSystem = {
      pkgs,
      config,
      system,
      devShells,
      inputs',
      ...
    }: let
      nvim   = inputs'.nixvim.packages.default;
      tmux   = inputs'.tmux.packages.default;
      cowsay = pkgs.cowsay;
      bash   = pkgs.bash;
      zsh    = pkgs.zsh;
    in
    {
      packages = {
        inherit cowsay nixvim tmux bash zsh;
        default = bash;
      };

      devShells.default = pkgs.mkShell {
        buildInputs = [nvim cowsay tmux];
      };
    };
  };
}
