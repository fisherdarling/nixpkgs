{ pkgs, lib, ... }:

{
  home.username = "fisher";

  home.packages = with pkgs; [
    file
    helix
    inetutils
    git
    gnupg
    fzf
    ripgrep
    nil
    clang
    htop    
    nil
    llvm
    gnumake
    perl
    rustup
    wezterm
    poetry
    zellij
    deno
    wasmtime
    nodejs
    discord

    # fonts
    fira-code
    fira-code-symbols
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  fonts.fontconfig.enable = true;
  

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "z"
        "ssh-agent"
        "fzf"
      ];
    };

    shellAliases = {
      gca = "git commit --amend --no-edit";
    };

    initExtra = ''
      export PATH="$HOME/.cargo/bin:$PATH"
      export PATH="$HOME/.rustup/:$PATH"
    '';
  };

  programs.git = {
    enable = true;
    userName = "fisher";
    userEmail = "fisher@darling.dev";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      github.copilot
      matklad.rust-analyzer
      bungcip.better-toml
      serayuzgur.crates
    ];
  };

  programs.helix = {
    enable = true;

    settings = {
      theme = "onedark";
      
      editor = {
        auto-format = true;
        lsp.display-messages = true; 
        file-picker.hidden = false;
      };
    };
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

  programs.wezterm = {
    enable = true;

    extraConfig = ''
      local wezterm = require 'wezterm'

      return {
        font = wezterm.font("FiraCode"),
        font_size = 14.0,
        hide_tab_bar_if_only_one_tab = true,
        window_padding = {
          left = 5,
          right = 5,
          top = 5,
          bottom = 5
        },
      }
    '';
  };

  programs.starship = {
    enable = true;

    settings = {
      hostname = {
        ssh_only = false;
      };
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
