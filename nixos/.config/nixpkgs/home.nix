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
  };
in
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # terminal apps
    htop
    (python3.withPackages(ps: with ps; [ numpy matplotlib pandas python-language-server virtualenv tqdm ]))

    # PL stuff
    unstable-small.elixir ruby_2_5 gcc gccStdenv stdenv_32bit

    # build tools
    file binutils

    # i3
    i3-gaps dmenu compton feh maim libnotify

    # fonts
    unstable-small.jetbrains-mono unstable-small.google-fonts

    # desktop apps
    calibre kitty google-chrome unstable-small.spotify unstable-small.playerctl unstable-small.slack

    unstable-small.silver-searcher
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
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
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
        modules-right = "pulseaudio";
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
        padding-right = 2;

        module-margin-left = 1;
        module-margin-right = 2;

        font-0 = "Montserrat:size=12;0";

# modules-left = date
# modules-center = i3
# modules-right = memory

        tray-position = "right";
        tray-padding = 2;
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%Y-%m-%d";
        time = "%H:%M";
        label = "%date% %time%";
      };
      "module/i3" = {
        type = "internal/i3";

        label-mode-padding = 2;
        label-mode-foreground = "#000";
        label-mode-background = "${colors.primary}";

        label-focused = "%name%";
        label-focused-background = "${colors.background-alt}";
        label-focused-underline = "${colors.primary}";
        label-focused-padding = 2;


        label-unfocused = "%name%";
        label-unfocused-foreground = "${colors.foreground-alt}";
        label-unfocused-padding = 2;

        # label-visible = "%name%";
        # label-visible-background = "${self.label-focused-background}";
        # label-visible-underline = "${self.label-focused-underline}";
        # label-visible-padding = "${self.label-focused-padding}";

        label-urgent = "%name%";
        label-urgent-background = "${colors.alert}";
        label-urgent-padding = 2;
      };
      "module/pulseaudio" = {
        type = "internal/pulseaudio";

        # ; Sink to be used, if it exists (find using `pacmd list-sinks`, name field)
        # ; If not, uses default sink
        sink = "analog-output-lineout";
        format-volume = "<ramp-volume> <label-volume>";

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
        label-muted = "🔇 muted";
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
        label = "%output:0:45:...%";
        exec = "~/.config/polybar/mediaplayer.sh";
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
