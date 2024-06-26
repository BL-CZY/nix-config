# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, nixpkgs, ... }:

{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  services.flatpak.enable = true;

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
    nvidiaSettings = true;
    powerManagement.enable = false;
    open = false;
  };

  fileSystems = {
    "/mnt/data" = {
      device = "/dev/nvme0n1p5";
      fsType = "ext4";
      options = [
        "users"
        "nofail"
      ];
    };

    "/mnt/windows" = {
      device = "/dev/nvme0n1p3";
      fsType = "ntfs-3g";
      options = [
        "rw"
        "users"
        "nofail"
      ];
    };
  };
  
  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # services.xserver.windowManager.i3 = {
    # enable = true;
    # extraPackages = with pkgs; [
      # dmenu #application launcher most people use
      # i3status # gives you the default i3 status bar
      # i3lock #default i3 screen locker
      # i3blocks #if you are planning on using i3blocks over i3status
   # ];
  # };

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;   
  boot.supportedFilesystems = [ "ntfs" ];
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
    "openssl-1.1.1w"
  ];    
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Malta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
 
  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';

  # security.pam.services.swaylock = {
  #   text = ''
  #     auth include login
  #   '';
  # };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tpl = {
    isNormalUser = true;
    description = "tpl";
    extraGroups = [ "networkmanager" "wheel" "input"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;  
  programs.steam.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Optional, hint electron apps to use wayland:
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };
  
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # services.xserver.enable = true;

  # services.displayManager = {
    # sddm.enable = true;
    # sddm.theme = "${import ./programs/sddm.nix {inherit pkgs; }}";
  # };

  services.gvfs.enable = true;
  programs.xfconf.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # nur.repos.xddxdd.wechat-uos
    obsidian
    libsForQt5.qt5.qtquickcontrols2   
    libsForQt5.qt5.qtgraphicaleffects
    vim
    wget
    git
    gh
    steam
    gimp
    jellyfin-ffmpeg
    home-manager
    hyprland
    kitty
    gtk3
    waybar
    eww
    swww
    networkmanagerapplet
    # dunst
    libnotify
    brightnessctl
    grim
    slurp
    # clipboard
    wl-clipboard
    cliphist
    wl-clip-persist
    xfce.thunar
    vlc
    obs-studio
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
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      # noto-fonts-cjk-sans
      # noto-fonts-cjk-serif
      source-han-sans
      source-han-serif
      # sarasa-gothic  #更纱黑体
      source-code-pro
      hack-font
      jetbrains-mono
    ];
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-material-color
      fcitx5-gtk
      libsForQt5.fcitx5-qt
    ];
  };
}
