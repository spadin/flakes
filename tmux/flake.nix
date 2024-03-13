{
  description = "Tmux config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    tmux-gruvbox = {
      url = "github:egel/tmux-gruvbox";
      flake = false;
    };
  };

  outputs = { nixpkgs, flake-utils, tmux-gruvbox, ... } @ inputs:
  flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs { inherit system; };
    tmux-gruvbox-light-conf = builtins.readFile ''${tmux-gruvbox}/tmux-gruvbox-light.conf'';
    local-tmux-conf = builtins.readFile ./tmux.conf;

    tmux-conf = pkgs.writeText "tmux.conf" ''
      ${local-tmux-conf}
      ${tmux-gruvbox-light-conf}
    '';

    tmux = with pkgs; symlinkJoin {
      name = "tmux";
      buildInputs = [ makeWrapper ];
      paths = pkgs.tmux;
      postBuild = ''
        wrapProgram "$out/bin/tmux" --add-flags "-f ${tmux-conf}"
      '';
    };
  in
  {
    packages = {
      default = tmux;
    };

    devShells.default = pkgs.mkShell {
      name = "tmux shell";
      packages = with pkgs; [ tmux ];

      # shellHook = ''
      #   alias tmux="tmux -f ${tmux-conf}/etc/tmux.conf"
      # '';
    };
  });
}