vim.cmd[[packadd packer.nvim]]

require'packer'.startup(function()
  use 'wbthomason/packer.nvim'

  -- ヤンクしたところをハイライトしてくれる
  use 'machakann/vim-highlightedyank'
  vim.g.highlightedyank_highlight_duration = 500
  vim.g.highlightedyank_max_lines = 1000
  vim.g.highlightedyank_timeout = 500

  -- vim-surround
  use 'machakann/vim-sandwich'

  -- f拡張
  use 'rhysd/clever-f.vim'
  vim.g.clever_f_ignore_case = 1
  vim.g.clever_f_smart_case = 1
  vim.g.clever_f_use_migemo = 1
  vim.g.clever_f_across_no_line = 1
  vim.g.clever_f_fix_key_direction = 1
  vim.g.clever_f_chars_match_any_signs = ';'

  use 'haya14busa/vim-edgemotion'
  vim.cmd[[
  map <C-j> <Plug>(edgemotion-j)
  map <C-k> <Plug>(edgemotion-k)
  ]]

  use 'vim-scripts/ReplaceWithRegister'

  -- テキストオブジェクト拡張
  use 'wellle/targets.vim'

  -- カーソル位置の単語で検索
  use 'thinca/vim-visualstar'

  -- yankring
  use 'bfredl/nvim-miniyank'
  vim.cmd[[
  map p <Plug>(miniyank-autoput)
  map P <Plug>(miniyank-autoPut)
  map <Space>p <Plug>(miniyank-startput)
  map <Space>P <Plug>(miniyank-startPut)
  map <Space>n <Plug>(miniyank-cycle)
  map <Space>N <Plug>(miniyank-cycleback)
  ]]

  use {
  'phaazon/hop.nvim',
  branch = 'v2', -- optional but strongly recommended
  config = function()
    require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
  end
  }
  vim.api.nvim_set_keymap('', '<Space>j', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>", {})
  vim.api.nvim_set_keymap('', '<Space>k', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>", {})


  -- vscode
  if vim.g.vscode then return end

  -- emmet
  use 'mattn/emmet-vim'

  -- カラースキーム
  use 'cocopon/pgmnt.vim'
  use 'cocopon/iceberg.vim'
  vim.cmd[[colorscheme iceberg]]

  -- 括弧の補完
  use 'cohama/lexima.vim'

  -- Ctrl-E
  use 'simeji/winresizer'

  -- comment
  use 'tomtom/tcomment_vim'

  -- ファイルツリー
  use 'lambdalisue/fern.vim'
  vim.api.nvim_set_keymap('n', '<C-n>', ':Fern . -reveal=% -drawer -toggle -width=40<CR>', {noremap = true})

  -- fern アイコン
  use 'lambdalisue/nerdfont.vim'
  use 'lambdalisue/fern-renderer-nerdfont.vim'
  vim.cmd[[let g:fern#renderer = "nerdfont"]]

  -- 
  use {
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
        map('n', '<Space>hS', gs.stage_buffer)
        map('n', '<Space>hu', gs.undo_stage_hunk)
        map('n', '<Space>hR', gs.reset_buffer)
        map('n', '<Space>hp', gs.preview_hunk)
        map('n', '<Space>hb', function() gs.blame_line{full=true} end)
        map('n', '<Space>tb', gs.toggle_current_line_blame)
        map('n', '<Space>hd', gs.diffthis)
        map('n', '<Space>hD', function() gs.diffthis('~') end)
        map('n', '<Space>td', gs.toggle_deleted)

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    }
  end
  }

  -- カラーコード
  use {
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
  end
  }

  -- indent
  vim.opt.list = true
  vim.opt.listchars:append "space:⋅"
  vim.opt.listchars:append "eol:↴"
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("indent_blankline").setup {
        show_end_of_line = true,
        space_char_blankline = " ",
      }
    end
  }
  use { 'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use { 'junegunn/fzf', run = './install --bin' }
  vim.api.nvim_set_keymap('n', '<Space>f', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<Space>b', "<cmd>lua require('fzf-lua').buffers()<CR>", { noremap = true, silent = true })

  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/vim-vsnip"

  require('mason').setup()
  require('mason-lspconfig').setup_handlers({ function(server)
    local opt = {
      -- -- Function executed when the LSP server startup
      -- on_attach = function(client, bufnr)
      --   local opts = { noremap=true, silent=true }
      --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      --   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
      -- end,
      capabilities = require('cmp_nvim_lsp').update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
      )
    }
    require('lspconfig')[server].setup(opt)
  end })

  -- 2. build-in LSP function
  -- keyboard shortcut
  vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
  vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
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
  -- LSP handlers
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
  )
  -- Reference highlight
  vim.cmd [[
  set updatetime=500
  highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
  highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
  highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
  augroup lsp_document_highlight
  autocmd!
  autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
  autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
  augroup END
  ]]

  -- スニペット
  use 'dcampos/nvim-snippy'
  use 'dcampos/cmp-snippy'

  -- 3. completion (hrsh7th/nvim-cmp)
  local cmp = require("cmp")
  cmp.setup({
    snippet = {
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body)
        require 'snippy'.expand_snippet(args.body)
      end,
    },
    sources = {
      { name = "nvim_lsp" },
      { name = 'snippy' },
      -- { name = "buffer" },
      -- { name = "path" },
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ['<C-l>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm { select = true },
    }),
    experimental = {
      ghost_text = true,
    },
  })
  -- cmp.setup.cmdline('/', {
  --   mapping = cmp.mapping.preset.cmdline(),
  --   sources = {
  --     { name = 'buffer' }
  --   }
  -- })
  -- cmp.setup.cmdline(":", {
  --   mapping = cmp.mapping.preset.cmdline(),
  --   sources = {
  --     { name = "path" },
  --     { name = "cmdline" },
  --   },
  -- })

  -- ステータスライン
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
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
  end
  }

  end)


