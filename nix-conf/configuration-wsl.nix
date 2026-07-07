# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.useWindowsDriver = true;

  virtualisation.docker.enable = true;

  networking.hostName = "nixos";

  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "ja_JP.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

  # 既存ユーザー"nixos"に追加設定をしたい場合はここに足す
  # (新規ユーザー"hosh"を別途作りたいならコメントアウトを外す)
  # users.users.hosh = {
  #   isNormalUser = true;
  #   description = "hosh";
  #   extraGroups = [ "wheel" ];
  #   shell = pkgs.zsh;
  # };

  users.users.nixos = {
    shell = pkgs.zsh;
    extraGroups = [ "docker" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.localBinInPath = true;

  environment.variables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib:${pkgs.stdenv.cc.cc.lib}/lib:/usr/lib/wsl/lib";
  };

  environment.systemPackages = with pkgs; [
    vim
    tailscale
    python313
    python313Packages.pip
    python313Packages.virtualenv
  ];

  services.tailscale.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  programs = {
    git.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib   # libstdc++.so.6
        zlib
        libGL
        glib
      ];
    };
    starship.enable = true;
    zsh.enable = true;
  };

  # NixOSが最初にインストールされた時のバージョン。変更しないこと。
  system.stateVersion = "24.05";
}

