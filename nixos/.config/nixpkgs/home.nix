{ pkgs, ... }:

let
  unstable-small = import <unstable-small>{
    config.allowUnfree = true;
  };
  nixpkgs = import <nixpkgs>{
    config.allowUnfree = true;
  };
  colors = {
    background = "#002b36";
    background-alt = "#002b36";
    foreground = "#dfdfdf";
    foreground-alt = "#555";
    primary = "#ffb52a";
    secondary = "#e60053";
    alert = "#bd2c40";
    yellow = "#b58900";
    orange = "#cb4b16";
    red = "#dc322f";
    magenta = "#d33682";
    violet = "#6c71c4";
    blue = "#268bd2";
    cyan = "#2aa198";
    green = "#859900";
  };
  pypi-i3-workspace-groups = pkgs.python37.pkgs.buildPythonPackage rec{
    pname = "i3-workspace-groups";
    version = "0.4.6";
    src = pkgs.python37.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "1sxgk47kia7psb24j5m7dfayiy4fs9wq7y0dvdp3lqjam0chlmrq";
    };
    propagatedBuildInputs = [
      pkgs.python37Packages.i3ipc
      pkgs.python37Packages.toml
    ];
    doCheck = false;
  };
  devour-git = pkgs.stdenv.mkDerivation rec{
    name = "devour";
    version = "1480b19cede29fd020763996053b4514910c74c6";

    src = pkgs.fetchFromGitHub {
      owner  = "salman-abedin";
      repo   = "devour";
      rev    = "1480b19cede29fd020763996053b4514910c74c6";
      sha256 = "01ng1j7p3xfg2wgl8zrf147mlk8fx1z0faavi57yya9vsmdnszpr";
    };

    buildInputs = with pkgs; [ autoconf pkgconfig gnumake xorg.libX11 xorg.libX11.dev xorg.libX11.dev.out openssl openssl.dev fontconfig xorg.libXft libxml2.dev libxml2 xorg.libXScrnSaver libxslt ];

    prePatch = ''
      substituteInPlace ./Makefile --replace "/usr/local/bin" "$out/bin"
    '';

    # buildPhase = ''
    #   cd ${src} && make install
    # '';
  };
in
{
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      # custom compilation of i3-workspace-groups fork of polybar
      (self: super: {
        polybar-git = super.polybar.overrideAttrs (oldAttrs: rec{
          name = "polybar";
          src = self.fetchFromGitHub {
            owner = "infokiller";
            repo = "polybar";
            rev = "76edb46e4cf47fd59cd193eb9d3b711683ab88d9";
            sha256 = "16iz07pdbilrbhckqf4by9ngl2993i9hs2lznwgs56fag5mzv9h0";
            fetchSubmodules = true;
          };
        });
      })
      (self: super: {
        neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: {
          name = "neovim";
          version = "master";
          src = self.fetchFromGitHub {
            owner = "neovim";
            repo = "neovim";
            rev = "ca6815115c79da62b845f479f0cdd765bdbfb700";
            sha256 = "0n95638jmpddaaaixlk4c8181d4q0f9y9cvwfmvgriwkflci88vq";
            fetchSubmodules = true;
          };
        });
      })
    ];
  };

  manual.manpages.enable = false;
  home.packages = with pkgs; [
    # terminal apps
    # unstable-small.neovim
    neovim-unwrapped
    unstable-small.tmux git stow gnumake htop unstable-small.silver-searcher unstable-small.mprime psensor tmate jq lm_sensors ranger w3m
    taskwarrior timewarrior taskopen rclone youtube-dl dnsutils calcurse efibootmgr ddccontrol ddccontrol-db pdfgrep xdotool devour-git parallel
    (python3.withPackages(ps: with ps; [ numpy matplotlib pandas python-language-server virtualenv tqdm i3ipc pynvim ]))

    (rstudioWrapper.override {
     packages = with pkgs.rPackages; let
       # llr = buildRPackage {
       # name = "llr";
       # src = pkgs.fetchFromGitHub {
       #  owner = "dirkschumacher";
       #  repo = "llr";
       #  rev = "0a654d469af231e9017e1100f00df47bae212b2c";
       #  sha256 = "0ks96m35z73nf2sb1cb8d7dv8hq8dcmxxhc61dnllrwxqq9m36lr";};
     # propagatedBuildInputs = [ rlang  knitr];
     # nativeBuildInputs = [ rlang knitr ];};
    in [knitr
        rlang
        ggplot2
        testthat
        assertthat
        # llr
        tidyverse
        ## the rest of your R packages here
        devtools];})

    (rWrapper.override {
     packages = with pkgs.rPackages; let
       # llr = buildRPackage {
       # name = "llr";
       # src = pkgs.fetchFromGitHub {
       #  owner = "dirkschumacher";
       #  repo = "llr";
       #  rev = "0a654d469af231e9017e1100f00df47bae212b2c";
       #  sha256 = "0ks96m35z73nf2sb1cb8d7dv8hq8dcmxxhc61dnllrwxqq9m36lr";};
     # propagatedBuildInputs = [ rlang  knitr];
     # nativeBuildInputs = [ rlang knitr ];};
    in [knitr
        rlang
        ggplot2
        testthat
        assertthat
        tidyverse
        devtools
        languageserver
        furrr
        pryr
      ];})

    # PL stuff
    unstable-small.elixir unstable-small.erlang ruby_2_5 gcc gccStdenv stdenv_32bit go jre yarn nodejs

    # build tools
    file binutils zip unzip inotify-tools caddy parted cargo

    # i3
    i3-gaps dmenu picom feh maim libnotify rofi pypi-i3-workspace-groups

    # fonts
    unstable-small.jetbrains-mono unstable-small.google-fonts unstable-small.noto-fonts-cjk	

    # desktop apps
    calibre kitty google-chrome unstable-small.spotify unstable-small.playerctl slack unstable-small.zoom-us mixxx androidStudioPackages.dev unstable-small.discord simplescreenrecorder zathura

    # laptop tools
    pavucontrol xorg.xev xorg.xmodmap arandr pciutils acpi powertop undervolt dfeet

    unstable-small.hey woeusb chntpw dmidecode vlc ffmpeg

    texlive.combined.scheme-full pandoc protonvpn-cli poppler pdftk texlab

    rnix-lsp
  ];

  xsession.enable = true;
  xsession.windowManager.command = "i3";
  services.udiskie.enable = true;

  # services.gpg-agent = {
  #   enable = true;
  #   defaultCacheTtl = 1800;
  #   enableSshSupport = true;
  # };

  programs.home-manager = {
    enable = true;
    path = "…";
  };

  programs.autorandr = {
    enable = true;
    hooks = {
      postswitch = {
        "restart-i3" = "${pkgs.i3}/bin/i3-msg restart";
        # "restart-polybar" = "sleep 10s && ~/.config/polybar/launch.sh";
      };
    };
  };

  fonts.fontconfig.enable = true;

  services.redshift = {
    enable = true;
    latitude = "37.3382";
    longitude = "-121.8863";
    tray = true;
    temperature = {
      day = 6500;
    };
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "Raleway";
        allow_markup = "yes";
        format = "<b>%s</b>\\n%b";
        sort = "yes";
        indicate_hidden = "yes";
        alignment = "center";
        word_wrap = "yes";
        ignore_newline = "no";
        geometry = "150x5-6+30";
        transparency = 0;
        sticky_history = "yes";
        line_height = 0;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        separator_color = "#586e75";
        startup_notification = true;
      };
      shortcuts = {
        close = "shift+space";
        history = "ctrl+shift+space";
      };
      urgency_low = {
        background = "#073642";
        foreground = "#eee8d5";
        timeout = 5;
      };
      urgency_normal = {
        background = "#073642";
        foreground = "#eee8d5";
        timeout = 20;
      };
      urgency_critical = {
        background = "#073642";
        foreground = "#dc322f";
        timeout = 0;
      };
    };
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybar-git.override {
      i3GapsSupport = true;
      pulseSupport = true;
      # alsaSupport = true;
      # githubSupport = true;
      # mpdSupport = true;
      # iwSupport = true;
      # nlSupport = true;
    };
    config = {
      "bar/secondary" = {
        monitor = "\${env:MONITOR}";
        modules-center = "i3";
        bottom = "true";
        background = "${colors.background}";
        foreground = "${colors.foreground}";

        fixed-center = true;

        line-size = 3;
        line-color = "#f00";

        border-top-size = 4;
        border-size = 4;
        border-color = "${colors.background}";

        padding-left = 0;
        padding-right = 1;

        module-margin-left = 1;
        module-margin-right = 1;

        font-0 = "Jetbrains Mono:size=12;0";
      };
      "bar/bottom" = {
        monitor = "\${env:MONITOR}";
        modules-left = "date music timew";
        modules-center = "i3";
        modules-right = "pulseaudio brightness battery";
        bottom = "true";
        background = "${colors.background}";
        foreground = "${colors.foreground}";

        fixed-center = true;

        line-size = 3;
        line-color = "#f00";

        border-top-size = 4;
        border-size = 4;
        border-color = "${colors.background}";

        padding-left = 0;
        padding-right = 1;

        module-margin-left = 1;
        module-margin-right = 1;

        font-0 = "Jetbrains Mono:size=12;0";

        tray-position = "right";
        tray-padding = 2;
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%m/%d";
        time = "%I:%M";
        label = "%date% %time%";
        label-underline = "${colors.blue}";
      };
      "module/i3" = {
        type = "internal/i3";

        pin-workspaces = true;
        strip-wsnumbers = true;
        workspaces-max-count = 10;

        label-mode-padding = 2;
        label-mode-foreground = "#000";
        label-mode-background = "${colors.primary}";

        label-focused = "%name%";
        label-focused-background = "${colors.background-alt}";
        label-focused-underline = "${colors.primary}";
        label-focused-padding = 1;


        label-unfocused = "%name%";
        label-unfocused-foreground = "${colors.foreground-alt}";
        label-unfocused-padding = 1;

        # label-visible = "%name%";
        # label-visible-background = "${self.label-focused-background}";
        # label-visible-underline = "${self.label-focused-underline}";
        # label-visible-padding = "${self.label-focused-padding}";

        label-urgent = "%name%";
        label-urgent-background = "${colors.alert}";
        label-urgent-padding = 1;
      };
      "module/pulseaudio" = {
        type = "internal/pulseaudio";

        # ; Sink to be used, if it exists (find using `pacmd list-sinks`, name field)
        # ; If not, uses default sink
        # sink = "analog-output-lineout";
        # format-volume = "<ramp-volume> <label-volume>";
        format-volume = "<label-volume>";
        format-volume-underline = "${colors.green}";
        format-muted-underline = "${colors.red}";

        # ; Available tags:
        # ;   <label-muted> (default)
        # ;   <ramp-volume>
        # ;   <bar-volume>
        # ;format-muted = "<label-muted>";

        # ; Available tokens:
        # ;   %percentage% (default)
        # ;   %decibels% (unreleased)
        # ;label-volume = %percentage%%

        # ; Available tokens:
        # ;   %percentage% (default)
        # ;   %decibels% (unreleased)
        label-muted = "muted";
        label-muted-foreground = "#666";

        # ; Only applies if <ramp-volume> is used
        ramp-volume-0 = "🔈";
        ramp-volume-1 = "🔉";
        ramp-volume-2 = "🔊";

        # ; Use PA_VOLUME_UI_MAX (~153%) if true, or PA_VOLUME_NORM (100%) if false
        # ; Default: true
        use-ui-max = true;

        # ; Interval for volume increase/decrease (in percent points)
        # ; Default: 5
        interval = 5;
      };
      "module/music" = {
        type = "custom/script";
        interval = "5s";
        format = "<label>";
        label = "%output:0:45:…%";
        exec = "~/.config/polybar/mediaplayer.sh";
        label-underline = "${colors.cyan}";
      };
      "module/brightness" = {
        type = "custom/script";
        interval = "5s";
        format = "<label>";
        label = "%output:0:45:…%";
        exec = "~/.config/polybar/brightness.sh";
        label-underline = "${colors.cyan}";
      };
      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";
        poll-interval = 5;
        time-format = "%H:%M";
        label-charging = "%percentage%%, %time% until full";
        label-discharging = "%percentage%%, %time% until empty";
        format-charging-underline = "${colors.blue}";
        format-discharging-underline = "${colors.blue}";
        format-full-underline = "${colors.blue}";
      };
      "module/timew" = {
        type = "custom/script";
        label = "%output%";
        tail = true;
        interval = 1;
        exec = "notify-send 'DUNST_COMMAND_PAUSE' && (timew | tail -n1 | awk '{print $2}')";
        # exec = "(timew && (timew | tail -n1 | awk '{print $2}')) && notify-send 'DUNST_COMMAND_PAUSE' || notify-send 'DUNST_COMMAND_RESUME'";
        exec-if = "timew || (notify-send 'DUNST_COMMAND_RESUME' && exit 1)";
        format = "<label>";
        # format-prefix = ""timew "";
        # format-padding = "4";
        # format-prefix-foreground = "# a color you want for the 'timew' label";
        # internal = 5;
        # date = "%m/%d";
        # time = "%I:%M";
        # label = "%date% %time%";
        label-underline = "${colors.green}";
      };
    };
    script = ''
    '';
  };

  # services.polybar.override = {
  #   i3GapsSupport = true;
  #   # alsaSupport = true;
  #   # iwSupport = true;
  #   # githubSupport = true;
  # };
}
