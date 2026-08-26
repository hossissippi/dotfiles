{ pkgs, ... }:
let
  plugins = (import ./plugins.nix { inherit pkgs; });
  migemoDict = (import ./migemo-dict.nix { inherit pkgs; });
in
{
  programs.nixvim = {
    enable = true;
    nixpkgs.config.allowUnfree = true;
    colorschemes.rose-pine = {
      enable = true;
      settings = {
        variant = "main";
        dark_variant = "moon";
        extend_background_behind_borders = true;
        enable = {
          legacy_highlight = true;
          migrations = true;
          terminal = true;
        };
        styles = {
          transparency = true;
        };
        groups = {
          border = "muted";
          link = "iris";
          panel = "surface";
        };
        highlight_groups = { };
        before_highlight = "function(group, highlight, palette) end";
      };
    };
    colorscheme = "rose-pine";
    globals = {
      mapleader = " ";
      # lua/migemo.lua が読む辞書。英単語キーを落としてある（migemo-dict.nix）
      migemo_dict = "${migemoDict}/share/migemo/utf-8/migemo-dict";
    };
    plugins = plugins.plugins;
    extraPlugins = plugins.extraPlugins;
    keymaps = (import ./keymaps.nix);
    # runtimepath 上の lua/ に置くので require("migemo") で引ける
    extraFiles."lua/migemo.lua".source = ./lua/migemo.lua;
    extraConfigLua = builtins.readFile ./init.lua;
  };
}
