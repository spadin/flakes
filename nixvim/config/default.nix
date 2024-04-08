{self, pkgs, ...}: {
  config = {
    options = {
      number = true;
      ignorecase = true;
      expandtab = true;
      hlsearch = true;
      incsearch = true;
      wrap = false;
      smartcase = true;
      smartindent = true;
      splitbelow = true;
      splitright = true;
      foldenable = true;
      tabstop = 2;
      shiftwidth = 2;
      mouse = "a";
    };

    colorschemes.gruvbox.enable = true;
    vimAlias = true;

    globals.mapleader = "\\";

    keymaps = [
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>g";
      }
      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader>f";
      }
    ];

    plugins = {
      lualine.enable = true;
      neo-tree = {
        enable = true;
        filesystem.filteredItems.showHiddenCount = false;
      };
      barbar.enable = true;
      barbar.keymaps.next = "gt";
      barbar.keymaps.previous = "gT";
      nix.enable = true;
      treesitter.enable = true;
      telescope.enable = true;
      comment-nvim.enable = true;
      lsp-format.enable = true;
      refactoring.enable = true;

      lsp = {
        enable = true;

        keymaps.lspBuf = {
          K = "hover";
          gD = "references";
          gd = "definition";
          gi = "implementation";
          gt = "type_definition";
        };

        servers = {
          tsserver.enable = true;

          lua-ls = {
            enable = true;
            settings.telemetry.enable = false;
          };

          rust-analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
        };
      };

      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp-buffer.enable = true;
      cmp.enable = true;
    };
  };
}
