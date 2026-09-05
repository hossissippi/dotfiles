{pkgs, ...}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "hosh";
        email = "hossissippi@gmail.com";
      };
      # コンフリクト時に共通の祖先も出す。delta 側もこれを整形して表示する
      merge.conflictstyle = "zdiff3";
      alias = {
        # 未追跡ファイルも含めて diff を見る。
        # --intent-to-add は「中身は空のまま index に名前だけ登録」する操作で、
        # これをしないと git は新規ファイルを diff の対象として認識しない。
        # 登録は `git reset` で取り消せる。
        da = "!git add --intent-to-add --all && git diff";
      };
    };
  };

  # git diff のページャ。行内の語単位ハイライトが主目的
  programs.delta = {
    enable = true;
    # pager.diff/log/show/blame と interactive.diffFilter を delta に向ける
    enableGitIntegration = true;
    options = {
      # nvim の colorscheme に合わせる。テーマ本体は programs/bat.nix で入れている
      # (delta は bat のテーマ機構を使う)
      syntax-theme = "rose-pine";
      # pager 内で n / N でファイル間をジャンプ
      navigate = true;
      line-numbers = true;
      # side-by-side は幅が狭いと読みにくい。herdr 経由だとリサイズで
      # 崩れることがあるので既定オフ。必要なら true にする
      side-by-side = false;
    };
  };
}
