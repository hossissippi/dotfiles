{pkgs, inputs, ...}: {
  home = rec {
    username="nixos";
    homeDirectory = "/home/${username}";
    stateVersion = "22.11";
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    eza
    httpie
    ripgrep
    claude-code
  ];

  imports = [
    (import ./programs/zsh.nix { pkgs = pkgs; })
    inputs.nixvim.homeModules.nixvim
    (import ./programs/nvim/nixvim.nix { pkgs = pkgs; })
    (import ./programs/tmux.nix { pkgs = pkgs; })
    (import ./programs/direnv.nix { pkgs = pkgs; })
  ];
}
