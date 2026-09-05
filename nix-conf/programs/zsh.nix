{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza --icons always --classify always";
      la = "eza --icons always --classify always --all --git";
      ll = "eza --icons always --long --all --git";
      lt = "eza --icons always --classify always --tree";
      gs = "git status";
      gb = "git branch";
    };
    initContent = ''
      bindkey '\^U' backward-kill-line;
      bindkey '\^K' kill-whole-line;
      eval "$(direnv hook zsh)"

      # ビープを鳴らさない。端末側の設定に依存せず、どの端末から使っても鳴らないように
      # シェル側で止めておく。
      #   BEEP      : 一般的なエラー
      #   LIST_BEEP : 補完候補が曖昧なとき
      #   HIST_BEEP : 履歴の端に達したとき
      unsetopt BEEP LIST_BEEP HIST_BEEP
    '';
  };
}
