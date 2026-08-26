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
    # パンくず（コードコンテキスト）
    navic = {
      enable = true;
      settings = {
        lsp.auto_attach = true;
        highlight = true;
        separator = " > ";
        depth_limit = 5;
        depth_limit_indicator = "..";
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
                "snacks_layout_box"
                "snacks_picker_input"
                "snacks_picker_list"
                "snacks_picker_preview"
            ];
          };
          # true (laststatus=3) にすると snacks picker の先頭行が隠れるバグがある (2.31.0 時点)
          globalstatus = false;
        };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "branch" ];
          lualine_c = [
            "filename"
            {
              __unkeyed-1 = "navic";
              # navic 側で highlight = true にしているので lualine の背景に合わせる
              color_correction = "static";
            }
              "diff"
          ];
          lualine_x = [
            "diagnostics"
          "encoding"
            "fileformat"
            "filetype"
            ];
          lualine_y = [ "progress" ];
          lualine_z = [
          {
            __unkeyed-1 = "location";
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
    # ミニマップ
    mini = {
      enable = true;
      modules = {
        map = {
          window = {
            side = "right";
            width = 10;
            winblend = 20;
            show_integration_count = false;
          };
          symbols = {
            # 既定の block('3x2') は Sextant (U+1FB00〜, Unicode 13) を使うが、
            # UDEV Gothic 35NFLG に1文字も入っておらず豆腐になる（cmap 実測 0/60）。
            # 点字の dot('4x2') も同様に未収録（0/256）。
            # Quadrant (U+2596〜) は収録済み（10/10）なので 2x2 を使う。
            encode.__raw = "require('mini.map').gen_encode_symbols.block('2x2')";
            scroll_line = "█";
            scroll_view = "┃";
          };
          integrations.__raw = ''
            {
              require('mini.map').gen_integration.builtin_search(),
              require('mini.map').gen_integration.diagnostic(),
              require('mini.map').gen_integration.gitsigns(),
            }
          '';
        };
      };
    };
    "web-devicons".enable = true;
    lsp = {
      enable = true;
      keymaps = {
        lspBuf = {
          "K"         = "hover";
          "<space>ld" = "definition";
          "<space>lD" = "declaration";
          "<space>lt" = "type_definition";
          "<space>li" = "implementation";
          "<space>lr" = "references";
          "<space>ln" = "rename";
          "<space>la" = "code_action";
          "<space>lf" = "format";
        };
        diagnostic = {
          "<space>le" = "open_float";
          "<space>lj" = "goto_next";
          "<space>lk" = "goto_prev";
        };
      };
      servers = {
        nixd.enable = true;
        lua_ls.enable = true;
        # Python は ruff と pyright で役割分担する。
        #   ruff    : 構文エラー・lint（実測 7ms）
        #   pyright : 型チェック・補完・定義ジャンプ（実測 460ms〜）
        # 構文エラーを見るのに pyright の型推論を待たされていたため ruff を追加した。
        # hover の競合は init.lua の LspAttach で pyright 側に寄せている。
        ruff.enable = true;
        pyright.enable = true;
        ts_ls.enable = true;
        rust_analyzer.enable = true;
        clangd.enable = true;
        jdtls.enable = true;
        kotlin_language_server.enable = true;
        gopls.enable = true;
      };
    };
    "blink-cmp" = {
      enable = true;
      settings = {
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
    noice = {
      enable = true;
      settings = {
        lsp = {
          override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
          };
          # サーバーが計算中かどうかが分からないと遅延の切り分けができないので出す
          progress.enabled = true;
        };
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          lsp_doc_border = true;
        };
      };
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    # pkgs.vimPlugins.clever‑f‑vim
  ];
}

