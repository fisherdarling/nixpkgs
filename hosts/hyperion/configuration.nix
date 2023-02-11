# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./sway.nix
#      (fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master")
    ];
   

  boot.supportedFilesystems = [ "ntfs" ];

  # boot using grub for os-prober
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      # assuming /boot is the mount point of the  EFI partition in NixOS (as the installation section recommends).
      efiSysMountPoint = "/boot";
    };
    grub = {
      # despite what the configuration.nix manpage seems to indicate,
      # as of release 17.09, setting device to "nodev" will still call
      # `grub-install` if efiSupport is true
      # (the devices list is not used by the EFI grub install,
      # but must be set to some value in order to pass an assert in grub.nix)
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;
      # set $FS_UUID to the UUID of the EFI partition
      extraEntries = ''
      menuentry "Windows" {
         insmod part_gpt
         insmod fat
         insmod search_fs_uuid
         insmod chain
         search --fs-uuid --set=root $FS_UUID
         chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      }
      '';
      version = 2;
      useOSProber = true;
    };
  };


  time.hardwareClockInLocalTime = true;


  networking.hostName = "hyperion"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  #console = {
  #  font = "Lat2-Terminus16";
  #  keyMap = "us";
  #  useXkbConfig = true; # use xkbOptions in tty.
  #};

  # programs.sway.enable = true;
  
  # For screen sharing
  # xdg.portal.wlr.enable = true;

  # Configure keymap in X11
 # services.xserver = {
#    enable = true;
   # autorun = false;
  #  layout = "us";
 #   desktopManager = {
#      default = "none";
    #  xterm.enable = false;
   #   lightdm.enable = true;
  #  };
 #   windowManager.i3.enable = true;
#  };    
  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.layout = "us";
  

#  services.vscode-server.enable = true;
# services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fisher = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
    ];
    shell = pkgs.zsh;
  };
  
  programs.zsh.enable = true;

  nix.settings.allowed-users = [ "fisher" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    curl
    wine
    bpftools
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  services.openssh.ports = [5151];
  
  programs.mosh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
  
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  
  networking.wireguard.interfaces = {
    # ohea0 = {
    #  ips = [ "200::3/7" ];
    #  listenPort = 50005;
    #  
    #  privateKeyFile = "/home/fisher/.wg/private.key";
    #  
    #  peers = [
    #    {
    #      publicKey = "EvRk1VzVD9o0ki+42KsW3Z3Wq1hObdDun5jMiA0aJXc=";
    #      allowedIPs = [ "200::/7" ];
    #      endpoint = "164.92.165.127:50005";
    #      persistentKeepalive = 25;
    #    }   
    #  ];        
    # };  

    ohea0 = {
      ips = [ "255::2/7" ];
      listenPort = 50004;

      privateKeyFile = "/home/fisher/.wg/private2.key";

      peers = [
        {
          publicKey = "EvRk1VzVD9o0ki+42KsW3Z3Wq1hObdDun5jMiA0aJXc=";
          allowedIPs = [ "200::/7" ];
          endpoint = "164.92.165.127:50005";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
