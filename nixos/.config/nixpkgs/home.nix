{ pkgs, ... }:

let
  unstable-small = import <unstable-small>{
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
in
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # terminal apps
    unstable-small.neovim unstable-small.tmux git stow gnumake htop unstable-small.silver-searcher unstable-small.mprime psensor tmate jq lm_sensors
    (python3.withPackages(ps: with ps; [ numpy matplotlib pandas python-language-server virtualenv tqdm ]))

    # PL stuff
    unstable-small.elixir ruby_2_5 gcc gccStdenv stdenv_32bit go jre

    # build tools
    file binutils zip

    # i3
    i3-gaps dmenu compton feh maim libnotify rofi

    # fonts
    unstable-small.jetbrains-mono unstable-small.google-fonts

    # desktop apps
    calibre kitty google-chrome unstable-small.spotify unstable-small.playerctl unstable-small.slack

    pavucontrol xorg.xev xorg.xmodmap arandr pciutils
  ];

  xsession.enable = true;
  xsession.windowManager.command = "i3";

  # services.gpg-agent = {
  #   enable = true;
  #   defaultCacheTtl = 1800;
  #   enableSshSupport = true;
  # };

  programs.home-manager = {
    enable = true;
    path = "…";
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
        font = "Raleway Bold";
        allow_markup = "yes";
        format = "<b>%s</b>\n%b";
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
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      pulseSupport = true;
      # alsaSupport = true;
      # githubSupport = true;
      # mpdSupport = true;
      # iwSupport = true;
      # nlSupport = true;
    };
    config = {
      "bar/bottom" = {
        modules-left = "date music";
        modules-center = "i3";
        modules-right = "pulseaudio brightness";
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

# modules-left = date
# modules-center = i3
# modules-right = memory

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
        sink = "analog-output-lineout";
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
