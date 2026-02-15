{pkgs, inputs, ...}: {
  home = rec {
    username="hosh";
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    eza
    httpie
    ripgrep
  ];

  imports = [
    (import ./programs/zsh.nix { pkgs = pkgs; })
    inputs.nixvim.homeModules.nixvim
    (import ./programs/nvim/nixvim.nix { pkgs = pkgs; })
    (import ./programs/tmux.nix { pkgs = pkgs; })
  ];
}
