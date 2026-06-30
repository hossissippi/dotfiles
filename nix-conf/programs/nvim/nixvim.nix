{ pkgs, ... }:
let
  plugins = (import ./plugins.nix { inherit pkgs; });
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
    globals.mapleader = " ";
    plugins = plugins.plugins;
    extraPlugins = plugins.extraPlugins;
    keymaps = (import ./keymaps.nix);
    extraConfigLua = builtins.readFile ./init.lua;
  };
}
