{ pkgs, ... }:
{
  plugins = {
    snacks = {
      enable = true;
      settings = {
        picker.enabled = true;
        indent.enabled = true;
        explorer.enabled = true;
        git.enabled = true;
      };
    };
    sandwich.enable = true;
    # 括弧の補完
    lexima.enable = true;
    # yankring
    yanky.enable = true;
    # 縦横移動
    hop = {
      enable = true;
      settings = {
      keys = "asdghklqwertyuiopzxcvbnmfj";
        quit_key = "<Esc>";
        reverse_distribution = false;
        x_bias = 10;
        teasing = true;
        virtual_cursor = true;
        jump_on_sole_occurrence = true;
        case_insensitive = false;
        dim_unmatched = true;
        direction = "require'hop.hint'.HintDirection.BEFORE_CURSOR";
        hint_position = "require'hop.hint'.HintPosition.BEGIN";
        hint_type = "require'hop.hint'.HintType.OVERLAY";
        match_mappings = [
          "zh"
          "zh_sc"
        ];
      };
    };
    # 画面分割
    "smart-splits" = {
      enable = true;
      settings = {
        resize_mode = {
          quit_key = "<ESC>";
          resize_keys = [
            "h"
            "j"
            "k"
            "l"
          ];
          silent = true;
        };
        ignored_events = [
          "BufEnter"
          "WinEnter"
        ];
      };
    };
    lualine = {
      enable = true;
      settings = {
        options = {
          disabled_filetypes = {
            __unkeyed-1 = "startify";
            __unkeyed-2 = "neo-tree";
            statusline = [
              "dap-repl"
            ];
            winbar = [
              "aerial"
                "dap-repl"
                "neotest-summary"
            ];
          };
          globalstatus = true;
        };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "branch" ];
          lualine_c = [
            "filename"
              "diff"
          ];
          lualine_x = [
            "diagnostics"
            {
              __unkeyed-1.__raw = ''
                function()
                local msg = ""
                local buf_ft = vim.bo[0].filetype
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if next(clients) == nil then
                  return msg
                    end
                    for _, client in ipairs(clients) do
                      local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                          return client.name
                            end
                            end
                            return msg
                            end
                            '';
              icon = "";
              color.fg = "#ffffff";
            }
          "encoding"
            "fileformat"
            "filetype"
            ];
          lualine_y = [
          {
            __unkeyed-1 = "aerial";
            cond.__raw = ''
              function()
              local buf_size_limit = 1024 * 1024
              if vim.api.nvim_buf_get_offset(0, vim.api.nvim_buf_line_count(0)) > buf_size_limit then
                return false
                  end

                  return true
                  end
                  '';
            sep = " ) ";
            depth.__raw = "nil";
            dense = false;
            dense_sep = ".";
            colored = true;
          }
          ];
          lualine_z = [
          {
            __unkeyed-1 = "location";
          }
          ];
        };
        tabline = {
          lualine_a = [
          {
            __unkeyed-1 = "buffers";
            symbols = {
              alternate_file = "";
            };
          }
          ];
          lualine_z = [ "tabs" ];
        };
        winbar = {
          lualine_c = [
          {
            __unkeyed-1 = "navic";
          }
          ];
          lualine_x = [
          {
            __unkeyed-1 = "filename";
            newfile_status = true;
            path = 3;
            shorting_target = 150;
          }
          ];
        };
      };
    };
    gitsigns = {
      enable = true;
      settings = {
        signs = {
          add.text = "│";
          change.text = "│";
          delete.text = "_";
          topdelete.text = "‾";
          changedelete.text = "~";
          untracked.text = "┆";
        };
        signcolumn = true;
        watch_gitdir.follow_files = true;
        current_line_blame = false;
        current_line_blame_opts = {
          virt_text = true;
          virt_text_pos = "eol";
        };
      };
    };
    diffview = {
      enable = true;
    };
    "web-devicons".enable = true;
    lspconfig.enable = true;
    "blink-cmp" = {
      enable = true;
      settingsExample = {
        keymap.preset = "super-tab";
        snippets.preset = "luasnip";
        sources = {
          providers = {
            buffer.score_offset = -7;
            lsp.fallbacks = [ ];
          };
          cmdline = [ ];
        };
        completion = {
          accept = {
            auto_brackets = {
              enabled = true;
              semantic_token_resolution.enabled = false;
            };
          };
          documentation.auto_show = true;
        };
        appearance = {
          use_nvim_cmp_as_default = true;
          nerd_font_variant = "normal";
        };
        signature.enabled = true;
      };
    };
    luasnip = {
      enable = true;
      settings = {
        update_events = [
          "TextChanged"
            "TextChangedI"
        ];
        keep_roots = true;
        link_roots = true;
        exit_roots = false;
        enable_autosnippets = true;
      };
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    # pkgs.vimPlugins.clever‑f‑vim
  ];
}

