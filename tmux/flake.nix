{
  description = "Tmux config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    tmux-gruvbox = {
      url = "github:egel/tmux-gruvbox";
      flake = false;
    };
  };

  outputs = { nixpkgs, tmux-gruvbox, ... } @ inputs:
  let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
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
    packages.${system} = {
      default = tmux;
    };

    devShells.${system}.default = pkgs.mkShell {
      name = "tmux shell";
      packages = with pkgs; [ tmux ];
    };
  };
}
