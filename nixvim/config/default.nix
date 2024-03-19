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
      nix.enable = true;
      treesitter.enable = true;
      telescope.enable = true;
      comment-nvim.enable = true;
      lsp-format.enable = true;

      lsp = {
        enable = true;

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

      nvim-cmp = {
        enable = true;
        sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
        ];

        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = {
            action = ''
            function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end
            '';
            modes = [ "i" "s" ];
          };
          "<S-Tab>" = {
            action = ''
            function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end
            '';
            modes = [ "i" "s" ];
          };
        };
      };
    };
  };
}
