{
  username,
  inputs,
  config,
  host,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  xdg.portal = {
    enable = true;

    config.common.default = "*";

    xdgOpenUsePortal = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];

    wlr.enable = true;
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [];
    };

    pulseaudio = {
      enable = false;
      package = pkgs.pulseaudioFull;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    enableRedistributableFirmware = true;
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs username host;};
    users.${username} = {
      imports = [./hm.nix];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    tmp.cleanOnBoot = true;

    kernelParams = ["nohibernate"];
    kernelModules = ["nvidia"];

    kernelPackages = pkgs.linuxPackages_latest;
  };

  security = {
    sudo = {
      enable = true;
      execWheelOnly = true;
      extraConfig = ''
        Defaults targetpw
      '';
    };

    rtkit.enable = true;
    polkit.enable = true;

    pam.services = {
      hyprlock = {};
    };
  };

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
      displayManager.gdm.enable = true;
    };

    displayManager = {
      autoLogin = {
        enable = false;
        user = "${username}";
      };
    };

    spice-vdagentd.enable = true;

    libinput = {
      enable = true;
      # mouse = {
      #   accelProfile = "flat";
      # };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    dbus.enable = true;
    gvfs.enable = true;

    kmscon = {
      enable = true;
      extraOptions = "--term xterm-256color";
      hwRender = true;
    };

    gpm.enable = true;

    fstrim.enable = true;

    printing = {
      enable = true;
      drivers = [pkgs.cnijfilter_4_00];
    };

    logind.extraConfig = ''
      #	don’t shutdown when power button is short-pressed
      #	HandlePowerKey=ignore
    '';
  };

  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 5";
      };
      flake = "/etc/nixos";
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    zsh.enable = true;

    dconf.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [proton-ge-bin];
    };

    gamemode.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      # pinentryFlavor = ""; # Uncomment and set the pinentry flavor if needed
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [];
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      ${username} = {
        description = "Marian";
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "lp"
          "libvirtd"
        ];
        hashedPassword = "$y$j9T$Zkw4AsRu8Om.xr/FoKJRz1$rATrla8D9I7lOagPp76BWHcCa1DHBi.uHOlYuKa0W21";
      };
    };
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };
    spiceUSBRedirection.enable = true;
  };

  nixpkgs = {
    overlays = [
      (final: prev: {
      })
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      allowed-users = ["${username}"];
      warn-dirty = true;
      substituters = ["https://nix-gaming.cachix.org"];
      trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
    };
  };

  networking.hostName = "${host}";

  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 100;
    priority = 999;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Kiev";

  system.stateVersion = config.system.nixos.release;
}
