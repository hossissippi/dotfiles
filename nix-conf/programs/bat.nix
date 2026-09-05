{pkgs, ...}: {
  programs.bat = {
    enable = true;
    themes = {
      # delta は bat のテーマ機構をそのまま使うので、ここに入れたものが
      # delta の syntax-theme からも選べるようになる。
      # nvim の colorscheme (rose-pine, variant = main) に合わせる用。
      rose-pine = {
        src = pkgs.fetchFromGitHub {
          owner = "rose-pine";
          repo = "tm-theme";
          rev = "6d556734541ccb04172e81fd58de4a35fff72d19";
          hash = "sha256-5+fG21KbB7bdPvszkz9Ftl6fCDGs17fJNTAXFRFWZGo=";
        };
        file = "dist/rose-pine.tmTheme";
      };
    };
  };
}
