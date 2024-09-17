{
  inputs,
  pkgs,
  lib,
  ...
}: let
  text = "rgb(251, 241, 199)";
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
    inputs.spicetify-nix.homeManagerModules.default
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      # hidpi = true;
    };
    systemd.enable = true;

    settings = {
      exec-once = [
	"hyprctl setcursor Bibata-Modern-Ice 24 &"
	""
      ];
      general = {
	"$mainMod" = "SUPER";
      };
      input = {
        kb_layout = "us,ru";
        kb_options ="grp:alt_caps_toggle";
      };
      bind = [
	"$mainMod, Q, killactive,"
	"$mainMod, RETURN, exec, rofi -show drun || pkill rofi"
	

	"$mainMod, 1, workspace, 1"
	"$mainMod, 2, workspace, 2"
	"$mainMod, 3, workspace, 3"
	"$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspacesilent, 1" # movetoworkspacesilent
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"

      ];
    };
    
  };

  programs = {
    waybar.enable = false;

    cava.enable = true;

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      userName = "Gnidga";
      userEmail = "oqomsm@gmail.com";
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    starship = {
      enable = true;

      enableBashIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;

      settings = {
        format = lib.concatStrings [
          "[](color_orange)"
          "$os"
          "[](bg:color_yellow fg:color_orange)"
          "$directory"
          "[](fg:color_yellow bg:color_aqua)"
          "$git_branch"
          "$git_status"
          "[](fg:color_aqua bg:color_blue)"
          "$nix_shell"
          "[](fg:color_blue bg:color_bg3)"
          "$cmd_duration"
          "[](fg:color_bg3) "
        ];

        palette = "gruvbox_dark";
        palettes.gruvbox_dark = {
          color_fg0 = "#fbf1c7";
          color_bg1 = "#3c3836";
          color_bg3 = "#665c54";
          color_blue = "#458588";
          color_aqua = "#689d6a";
          color_green = "#98971a";
          color_orange = "#d65d0e";
          color_purple = "#b16286";
          color_red = "#cc241d";
          color_yellow = "#d79921";
        };

        os = {
          disabled = false;
          style = "bg:color_orange bold fg:color_fg0";
          symbols = {
            NixOS = " ";
          };
        };

        directory = {
          style = "bold fg:color_fg0 bg:color_yellow";
          format = "[ $path ]($style)";
          truncation_length = 3;
        };

        git_branch = {
          symbol = "";
          style = "bg:color_aqua";
          format = "[[ $symbol $branch ](bold fg:color_fg0 bg:color_aqua)]($style)";
        };

        git_status = {
          style = "bg:color_aqua bold fg:color_fg0";
          format = "[$all_status$ahead_behind]($style)";
        };

        nix_shell = {
          format = "[ via nix $name ]($style)";
          style = "bg:color_blue bold fg:color_fg0";
        };

        time = {
          disabled = false;
          time_format = "%R";
          style = "bg:color_bg1";
          format = "[[   $time ](fg:color_fg0 bg:color_bg1)]($style)";
        };

        cmd_duration = {
          format = "[ 󰔛 $duration ]($style)";
          disabled = false;
          style = "bg:color_bg3 fg:color_fg0";
          show_notifications = false;
          min_time_to_notify = 60000;
        };

        line_break = {
          disabled = false;
        };

        character = {
          disabled = false;
          success_symbol = "[  ](bold fg:color_green)";
          error_symbol = "[  ](bold fg:color_red)";
        };
      };
    };

    micro = {
      enable = true;
      settings = {
        "colorscheme" = "gruvbox";
        "*.nix" = {"tabsize" = 2;};
        "*.ml" = {"tabsize" = 2;};
        "*.sh" = {"tabsize" = 2;};
        "makefile" = {"tabstospaces" = false;};
        "tabstospaces" = true;
        "tabsize" = 4;
        "mkparents" = true;
        "colorcolumn" = 80;
      };
    };

    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "gruvbox-dark";
      };
      extraPackages = with pkgs.bat-extras; [
        batman
        batpipe
        batgrep
        # batdiff
      ];
    };

    kitty = {
      enable = true;

      theme = "Gruvbox Dark Hard";

      font = {
        name = "CaskaydiaCove Nerd Font";
        size = 10;
      };

      settings = {
        confirm_os_window_close = 0;
        background_opacity = "0.75";
        window_padding_width = 10;
        scrollback_lines = 10000;
        enable_audio_bell = false;
        mouse_hide_wait = 60;

        ## Tabs
        tab_title_template = "{index}";
        active_tab_font_style = "normal";
        inactive_tab_font_style = "normal";
        tab_bar_style = "powerline";
        tab_powerline_style = "angled";
        active_tab_foreground = "#FBF1C7";
        active_tab_background = "#7C6F64";
        inactive_tab_foreground = "#FBF1C7";
        inactive_tab_background = "#3C3836";
      };

      keybindings = {
        "ctrl+shift+left" = "no_op";
        "ctrl+shift+right" = "no_op";
      };
    };

    neovim = {
      enable = true;
      vimAlias = true;
    };

    btop = {
      enable = true;

      settings = {
        color_theme = "TTY";
        theme_background = false;
        update_ms = 500;
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [];
      };
    };

    spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle
      ];
      theme = spicePkgs.themes.dribbblish;
      colorScheme = "gruvbox-material-dark";
    };
  };

  xdg = {
    configFile = {
      "hypr/hyprlock.conf".text = ''
        # BACKGROUND
        background {
          monitor =
          path = ${/etc/nixos/wallpapers/forest.jpg}
          blur_passes = 1
          contrast = 0.8916
          brightness = 0.8172
          vibrancy = 0.1696
          vibrancy_darkness = 0.0
        }

        # GENERAL
        general {
          hide_cursor = true
          no_fade_in = false
          grace = 0
          disable_loading_bar = false
        }

        # TIME
        label {
          monitor =
          text = cmd[update:1000] echo "$(date +"%k:%M")"
          color = rgba(235, 219, 178, .9)
          font_size = 111
          font_family = JetBrainsMono NF Bold
          position = 0, 270
          halign = center
          valign = center
        }

        # DAY
        label {
          monitor =
          text = cmd[update:1000] echo "- $(date +"%A, %B %d") -"
          color = rgba(235, 219, 178, .9)
          font_size = 20
          font_family = CaskaydiaCove Nerd Font
          position = 0, 160
          halign = center
          valign = center
        }

        # USER-BOX
        shape {
          monitor =
          size = 350, 50
          color = rgba(225, 225, 225, .2)
          rounding = 15
          border_size = 0
          border_color = rgba(255, 255, 255, 0)
          rotate = 0
          position = 0, -230
          halign = center
          valign = center
        }

        # USER
        label {
          monitor =
          text =   $USER
          color = rgba(235, 219, 178, .9)
          font_size = 16
          font_family = CaskaydiaCove Nerd Font
          position = 0, -230
          halign = center
          valign = center
        }

        # INPUT FIELD
        input-field {
          monitor =
          size = 350, 50
          outline_thickness = 0
          rounding = 15
          dots_size = 0.25 # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.4 # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true
          outer_color = rgba(255, 255, 255, 0)
          inner_color = rgba(225, 225, 225, 0.2)
          color = rgba(235, 219, 178, .9)
          font_color = rgba(235, 219, 178, .9)
          fade_on_empty = false
          placeholder_text = <i><span foreground="##ebdbb2e5">Enter Password</span></i>
          hide_input = false
          position = 0, -300
          halign = center
          valign = center
        }
      '';

      "rofi/theme.rasi".text = ''
        * {
          bg-col: #1D2021;
          bg-col-light: #282828;
          border-col: #928374;
          selected-col: #3C3836;
          green: #98971A;
          fg-col: #FBF1C7;
          fg-col2: #EBDBB2;
          grey: #BDAE93;
          highlight: @green;
        }
      '';

      "rofi/config.rasi".text = ''
        configuration {
          modi: "run,drun,window";
          lines: 5;
          cycle: false;
          font: "JetBrainsMono NF Bold 15";
          show-icons: true;
          icon-theme: "Papirus-dark";
          terminal: "kitty";
          drun-display-format: "{icon} {name}";
          location: 0;
          disable-history: true;
          hide-scrollbar: true;
          display-drun: " Apps ";
          display-run: " Run ";
          display-window: " Window ";
          sidebar-mode: true;
          sorting-method: "fzf";
        }

        @theme "theme"

        element-text, element-icon, mode-switcher {
          background-color: inherit;
          text-color: inherit;
        }

        window {
          height: 480px;
          width: 400px;
          border: 3px;
          border-color: @border-col;
          background-color: @bg-col;
        }

        mainbox {
          background-color: @bg-col;
        }

        inputbar {
          children: [prompt, entry];
          background-color: @bg-col-light;
          border-radius: 5px;
          padding: 0px;
        }

        prompt {
          background-color: @green;
          padding: 4px;
          text-color: @bg-col-light;
          border-radius: 3px;
          margin: 10px 0px 10px 10px;
        }

        textbox-prompt-colon {
          expand: false;
          str: ":";
        }

        entry {
          padding: 6px;
          margin: 10px 10px 10px 5px;
          text-color: @fg-col;
          background-color: @bg-col;
          border-radius: 3px;
        }

        listview {
          border: 0px 0px 0px;
          padding: 6px 0px 0px;
          margin: 10px 0px 0px 6px;
          columns: 1;
          background-color: @bg-col;
        }

        element {
          padding: 8px;
          margin: 0px 10px 4px 4px;
          background-color: @bg-col;
          text-color: @fg-col;
        }

        element-icon {
          size: 28px;
        }

        element selected {
          background-color: @selected-col;
          text-color: @fg-col2;
          border-radius: 3px;
        }

        mode-switcher {
          spacing: 0;
        }

        button {
          padding: 10px;
          background-color: @bg-col-light;
          text-color: @grey;
          vertical-align: 0.5;
          horizontal-align: 0.5;
        }

        button selected {
          background-color: @bg-col;
          text-color: @green;
        }
      '';

      "cava/config".text = ''
        # custom cava config

        [general]
        autosens = 1
        overshoot = 0

        [color]
        gradient = 1
        gradient_count = 8

        gradient_color_1 = '#99991a'
        gradient_color_2 = '#a28e00'
        gradient_color_3 = '#ab8200'
        gradient_color_4 = '#b37400'
        gradient_color_5 = '#bb6600'
        gradient_color_6 = '#c25400'
        gradient_color_7 = '#c8400d'
        gradient_color_8 = '#cd231d'
      '';
    };
  };

  home = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      DISABLE_QT5_COMPAT = "0";
      GDK_BACKEND = "wayland";
      ANKI_WAYLAND = "1";
      DIRENV_LOG_FORMAT = "";
      WLR_DRM_NO_ATOMIC = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORM = "xcb";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_STYLE_OVERRIDE = "kvantum";
      MOZ_ENABLE_WAYLAND = "1";
      WLR_BACKEND = "vulkan";
      WLR_RENDERER = "vulkan";
      WLR_NO_HARDWARE_CURSORS = "1";
      XDG_SESSION_TYPE = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      GTK_THEME = "Gruvbox-Dark";
    };
    packages = with pkgs; [
      rofi-wayland
      hyprlock
      adwaita-icon-theme
      abiword
      bat
      cava
      clipman
      dconf
      dmenu
      discord
      feh
      ffmpeg
      fastfetch
      firefox
      flameshot
      eza
      spice
      spice-gtk
      spice-protocol
      git
      gcc
      gnumake
      home-manager
      hwinfo
      imv
      inxi
      kitty
      libreoffice-qt6-still
      lazygit
      less
      lshw
      mangohud
      mediainfo
      mpv
      nix-prefetch-git
      nodejs
      neofetch
      okular
      obs-studio
      fd
      ripgrep
      ncdu
      tldr
      entr
      gtt
      audacity
      bleachbit
      qalculate-gtk
      onefetch
      hyprpicker
      grim
      direnv
      wayland
      glib
      wf-recorder
      wl-clip-persist
      slurp
      inputs.hypr-contrib.packages.${pkgs.system}.grimblast
      yazi
      valgrind
      pavucontrol
      pciutils
      picom
      ranger
      tree
      telegram-desktop
      unzip
      virt-manager
      virt-viewer
      viber
      win-virtio
      win-spice
      wget
      wpsoffice
      xfce.thunar
      yt-dlp
      zram-generator
      zip
      (lutris.override {
        extraPkgs = pkgs: [
          wineWowPackages.stable
          winetricks
        ];
      })
      inputs.alejandra.defaultPackage.${system}
      nvtopPackages.intel
    ];
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
    ];

  fonts.fontconfig.enable = true;
}
