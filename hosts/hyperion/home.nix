{ pkgs, lib, ... }:
{
  imports = [ ../../home-manager/common.nix ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      github.copilot
      matklad.rust-analyzer
      bungcip.better-toml
      serayuzgur.crates
    ];
  };

    programs.i3status-rust = {
    enable = true;
  };

  xsession.windowManager.i3 = {
    enable = true;

    config = rec {
      modifier = "Mod1";
      terminal = "wezterm";

      gaps.inner = 10;
      gaps.outer = 10;      
      
      window.titlebar = false;

      fonts = {
        size = 32.0;
      };

      menu = "${pkgs.rofi}/bin/rofi";

      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
          fonts = {
            size = 16.0;
          };
        }
      ];

      keybindings = lib.mkOptionDefault {
       "${modifier}+d" = "exec --no-startup-id rofi -show drun";
      };
    };
  };

  programs.rofi = {
    enable = true;
    terminal = "${pkgs.wezterm}/bin/wezterm";
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
    sshKeys = [
      "/Users/fisher/.ssh/id_ed25519"
    ];
  };
}