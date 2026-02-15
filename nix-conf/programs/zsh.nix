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
  };
}
