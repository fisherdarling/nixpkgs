{ pkgs, ... }:
{
  imports = [ ../../home-manager/common.nix ];

  home.packages = with pkgs; [
    darwin.apple_sdk.frameworks.Security
    darwin.apple_sdk.frameworks.CoreServices
  ];

  programs.zsh.initExtra = "\nexport LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix)/lib:$(brew --prefix)/opt/libiconv/lib";

  programs.starship.settings.custom = {
    cdnr = {
      command = "cdnr";
      when = true;
    };
  };
}