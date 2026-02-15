[
  # snacks
  {
    key = "<space>e";
    mode = [ "n" ];
    action = "<cmd>lua Snacks.explorer()<CR>";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "<space>F";
    mode = [ "n" ];
    action = "<cmd>lua Snacks.picker.files()<CR>";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "<space>f";
    mode = [ "n" ];
    action = "<cmd>lua Snacks.picker.grep()<CR>";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "<space>/";
    mode = [ "n" ];
    action = "<cmd>lua Snacks.picker.lines()<CR>";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "<space>b";
    mode = [ "n" ];
    action = "<cmd>lua Snacks.picker.buffers()<CR>";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "<space>gl";
    mode = [ "n" ];
    action = "<cmd>lua Snacks.picker.git_log()<CR>";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "<space>gs";
    mode = [ "n" ];
    action = "<cmd>lua Snacks.picker.git_status()<CR>";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "<space>gb";
    mode = [ "n" ];
    action = "<cmd>lua Snacks.git.blame_line()<CR>";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "<space>uC";
    mode = [ "n" ];
    action = "<cmd>lua Snacks.picker.colorschemes()()<CR>";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "<space>:";
    mode = [ "n" ];
    action = "<cmd>lua Snacks.picker.command_history()()<CR>";
    options = {
      silent = true;
      noremap = true;
    };
  }
  # yanky
  {
    key = "p";
    mode = [ "n" "x" ];
    action = "<Plug>(YankyPutAfter)";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "P";
    mode = [ "n" "x" ];
    action = "<Plug>(YankyPutBefore)";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "<c-p>";
    mode = [ "n" "x" ];
    action = "<Plug>(YankyPreviousEntry)";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "<c-n>";
    mode = [ "n" "x" ];
    action = "<Plug>(YankyNextEntry)";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "f";
    action.__raw = ''
      function()
      require'hop'.hint_char1({
          direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
          current_line_only = true
          })
      end
    '';
    options.remap = true;
  }
  {
    key = "F";
    action.__raw = ''
      function()
      require'hop'.hint_char1({
          direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
          current_line_only = true
          })
      end
    '';
    options.remap = true;
  }
  {
    key = "t";
    action.__raw = ''
      function()
      require'hop'.hint_char1({
          direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
          current_line_only = true,
          hint_offset = -1
          })
      end
    '';
    options.remap = true;
  }
  {
    key = "T";
    action.__raw = ''
      function()
      require'hop'.hint_char1({
          direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
          current_line_only = true,
          hint_offset = 1
          })
      end
    '';
    options.remap = true;
  }
  {
    key = "<space>j";
    action.__raw = ''
      function()
      require'hop'.hint_char1({
          direction = require'hop.hint'.HintDirection.AFTER_CURSOR
          })
      end
    '';
    options.remap = true;
  }
  {
    key = "<space>k";
    action.__raw = ''
      function()
      require'hop'.hint_char1({
          direction = require'hop.hint'.HintDirection.BEFORE_CURSOR
          })
      end
    '';
    options.remap = true;
  }
  # resize window
  {
    key = "<A-h>";
    mode = [ "n" ];
    action = "<cmd>lua require('smart-splits').resize_left()<CR>";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "<A-j>";
    mode = [ "n" ];
    action = "<cmd>lua require('smart-splits').resize_down()<CR>";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "<A-k>";
    mode = [ "n" ];
    action = "<cmd>lua require('smart-splits').resize_up()<CR>";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "<A-l>";
    mode = [ "n" ];
    action = "<cmd>lua require('smart-splits').resize_right()<CR>";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "<space>gdo";
    mode = [ "n" ];
    action = "<cmd>DiffviewOpen<CR>";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "<space>gdc";
    mode = [ "n" ];
    action = "<cmd>DiffviewClose<CR>";
    options = {
      silent = true;
      noremap = true;
    };
  }
  {
    key = "<space>gdh";
    mode = [ "n" ];
    action = "<cmd>DiffviewFileHistory<CR>";
    options = {
      silent = true;
      noremap = true;
    };
  }
]
