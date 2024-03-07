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

    extraPlugins = with pkgs.vimPlugins; [
      vim-prettier
    ];

    plugins = {
      lualine.enable = true;
      neo-tree.enable = true;
      bufferline.enable = true;
      nix.enable = true;
      treesitter.enable = true;
      telescope.enable = true;

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

      nvim-cmp = {
        enable = true;
        autoEnableSources = true;
        sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
          {name = "luasnip";}
        ];

        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = {
            action = ''
            function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expandable() then
                luasnip.expand()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif check_backspace() then
                fallback()
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
