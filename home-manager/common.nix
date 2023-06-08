{ pkgs, ... }:

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

  programs.wezterm = {
    enable = true;

    extraConfig = ''
      local wezterm = require 'wezterm'

      return {
        font = wezterm.font 'Fira Code',
        font_size = 12.0,
        hide_tab_bar_if_only_one_tab = true,
        color_scheme = 'Ocean Dark (Gogh)',
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

      add_newline = false;
    };
  };
}
