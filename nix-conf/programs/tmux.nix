{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # --- Prefix ---
      set-option -g prefix C-a
      unbind-key C-b
      bind-key C-a send-prefix

      # --- ステータスバー ---
      set-option -g status-bg colour235
      set-option -g status-fg colour136
      set-option -g status-left "#[fg=green]#H"
      set-option -g status-right "#[fg=yellow]%Y-%m-%d %H:%M | #h | #F"

      # --- ウィンドウ & ペイン操作 ---
      bind-key | split-window -h
      bind-key - split-window -v
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      # --- マウス操作 ---
      set -g mouse on

      # --- クリップボード（Linux/X11の場合） ---
      setw -g mode-keys vi
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -sel clip -i"

      # --- 便利オプション ---
      set -g history-limit 10000
      setw -g aggressive-resize on
      set-option -g default-terminal "screen-256color"
  '';
  };
}
