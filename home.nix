{ config, pkgs, ... }:

{
  home.username = "fisher";
  home.homeDirectory = "/home/fisher";
  
  home.packages = with pkgs; [
    helix
    inetutils
    git
  ];
  
  home.stateVersion = "22.05";
  
  programs.home-manager.enable = true;
  
  programs.git = {
    enable = true;
    userName = "fisher";
    userEmail = "fisher@darling.dev";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}