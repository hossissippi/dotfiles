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

end)
