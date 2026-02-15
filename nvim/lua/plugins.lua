-- vim.cmd[[packadd packer.nvim]]

common = {
  {
    -- yank したところをハイライトしてくれる
    'machakann/vim-highlightedyank',
    init = function()
      vim.g.highlightedyank_highlight_duration = 500
      vim.g.highlightedyank_max_lines = 1000
      vim.g.highlightedyank_timeout = 500
    end,
  },
  -- vim-surround
  'machakann/vim-sandwich',
  -- 括弧の補完
  'cohama/lexima.vim',
  {
    -- f 拡張
    'rhysd/clever-f.vim',
    init = function()
      vim.g.clever_f_ignore_case = 1
      vim.g.clever_f_smart_case = 1
      vim.g.clever_f_use_migemo = 1
      vim.g.clever_f_across_no_line = 1
      vim.g.clever_f_fix_key_direction = 1
      vim.g.clever_f_chars_match_any_signs = ';'
    end,
  },
  {
    -- コードブロックの端に移動できる
    'haya14busa/vim-edgemotion',
    init = function()
      vim.cmd[[
      map <C-j> <Plug>(edgemotion-j)
      map <C-k> <Plug>(edgemotion-k)
      ]]
    end,
  },
  -- gr
  'vim-scripts/ReplaceWithRegister',
  -- comment
  'tomtom/tcomment_vim',
  -- テキストオブジェクト拡張
  'wellle/targets.vim',
  -- カーソル位置の単語で検索
  'thinca/vim-visualstar',
  {
    -- yankring
    'bfredl/nvim-miniyank',
    init = function()
      vim.cmd[[
      map p <Plug>(miniyank-autoput)
      map P <Plug>(miniyank-autoPut)
      map <Space>p <Plug>(miniyank-startput)
      map <Space>P <Plug>(miniyank-startPut)
      map <Space>n <Plug>(miniyank-cycle)
      map <Space>N <Plug>(miniyank-cycleback)
      ]]
    end,
  },
  {
    -- 縦の移動
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end,
    init = function()
      vim.api.nvim_set_keymap('', '<Space>j', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>", {})
      vim.api.nvim_set_keymap('', '<Space>k', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>", {})
    end,
  },
}

not_vscode = {
  -- カラースキーム
  'cocopon/pgmnt.vim',
  {
    'cocopon/iceberg.vim',
    init = function()
      vim.cmd[[colorscheme iceberg]]
    end,
  },
  {
    -- カラーコード
    'norcalli/nvim-colorizer.lua',
    config = function()
      require 'colorizer'.setup {
        'css';
        'javascript';
        'lua';
        html = {
          mode = 'foreground';
        }
      }
    end,
    ft = {'css', 'js', 'lua'},
  },
  -- Ctrl-E window リサイズ
  'simeji/winresizer',
  -- emmet
  'mattn/emmet-vim',
  {
    -- ファイラ
    'lambdalisue/fern.vim',
    config = function()
      vim.api.nvim_set_keymap('n', '<C-n>', ':Fern . -reveal=% -drawer -toggle -width=40<CR>', {noremap = true, silent = true})
    end,
  },
  {
    -- fern アイコン
    'lambdalisue/fern-renderer-nerdfont.vim',
    dependencies = {'lambdalisue/nerdfont.vim', 'lambdalisue/fern.vim'},
    init = function()
      vim.cmd[[let g:fern#renderer='nerdfont']]
    end,
  },
  'lambdalisue/fern-git-status.vim',
  {
    -- indent
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.opt.list = true
      vim.opt.listchars:append "space:⋅"
      vim.opt.listchars:append "eol:↴"
      require("ibl").setup {
      }
    end,
  },
  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'kyazdani42/nvim-web-devicons', },
    config = function()
      vim.api.nvim_set_keymap('n', '<Space>f', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Space>b', "<cmd>lua require('fzf-lua').buffers()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Space>/', "<cmd>lua require('fzf-lua').blines()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Space>B', "<cmd>lua require('fzf-lua').lines()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Space>F', "<cmd>lua require('fzf-lua').grep_project()<CR>", { noremap = true, silent = true })
    end,
  },
  'junegunn/fzf',
  {
    -- ステータスライン
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons'},
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '|', right = '|'},
          section_separators = '',
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
          change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
          delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        },
        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        yadm = {
          enable = false
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          -- Actions
          map({'n', 'v'}, '<Space>hs', ':Gitsigns stage_hunk<CR>')
          map({'n', 'v'}, '<Space>hr', ':Gitsigns reset_hunk<CR>')
          map('n', '<Space>tb', gs.toggle_current_line_blame)
          map('n', '<Space>hd', gs.diffthis)
          map('n', '<Space>hD', function() gs.diffthis('~') end)
          map('n', '<Space>td', gs.toggle_deleted)

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      }
    end,
  },
  -- lsp
  {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers {
        function(server)
          require('lspconfig')[server].setup {
            on_attach = function(client, bufnr)
            -- keyboard shortcut
            vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
            vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>')
            vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
            vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
            vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
            vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
            vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
            vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
            vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
            vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
            vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
            vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
          end,
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
        }
        end
      }
      end
  },
  'neovim/nvim-lspconfig',
  {
    --補完エンジン
    'hrsh7th/nvim-cmp',
    config = function()
      -- Lspkindのrequire
      local lspkind = require 'lspkind'
      --補完関係の設定
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require 'snippy'.expand_snippet(args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = 'snippy' }, 
          { name = "buffer" },
          { name = "path" },
          { name = "cmdline" },
          { name = "git" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(), --Ctrl+pで補完欄を一つ上に移動
          ["<C-n>"] = cmp.mapping.select_next_item(), --Ctrl+nで補完欄を一つ下に移動
          ['<C-l>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm { select = true },
        }),
        experimental = {
          ghost_text = false,
        },
        -- Lspkind(アイコン)を設定
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          })
        }
      })
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },　--ソース類を設定
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "path" },　--ソース類を設定
        },
      })
    end,
  },
  -- 補完ソース
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'dcampos/nvim-snippy',
  'dcampos/cmp-snippy',
  'petertriho/cmp-git',
  'hrsh7th/cmp-cmdline',
  -- nvim-cmp と連携して補完欄にアイコンを表示
  'onsails/lspkind.nvim',
}

if not vim.g.vscode then
  for i=1,#not_vscode do
    common[#common+1] = not_vscode[i]
  end
end

require("lazy").setup(common)
