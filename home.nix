{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import "${fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz"}/overlay.nix")
  ];

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
    cargo
    wezterm
    poetry
    zellij
    deno
    wasmtime
  ];

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

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

  # services.gpg-agent = {
  #   enable = true;
  #   defaultCacheTtl = 1800;
  #   enableSshSupport = true;
  #   sshKeys = [
  #     "/Users/fisher/.ssh/id_ed25519"
  #   ];
  # };
}
