{ config, pkgs, ... }:

{
  home.username = "fisher";
  
  home.packages = with pkgs; [
    helix
    inetutils
    git
    gnupg
  ];
  
  home.stateVersion = "22.11";
  
  programs.home-manager.enable = true;
  
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "z"
        "ssh-agent"
      ];
    };
  };
  
  programs.git = {
    enable = true;
    userName = "fisher";
    userEmail = "fisher@darling.dev";
    extraConfig = {
      init.defaultBranch = "main";
    };
    aliases = {
      gca = "git commit --amend --no-edit";
    };
  };
  
  # services.gpg-agent = {
  #   enable = true;
  #   defaultCacheTtl = 1800;
  #   enableSshSupport = true;
  #   sshKeys = [
  #     "/Users/fisher/.ssh/id_ed25519"
  #   ];
  # };
}