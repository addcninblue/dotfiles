{ pkgs, ... }:

let
  unstable-small = import <unstable-small>{};
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
  home.packages = [
    pkgs.htop
    (pkgs.python3.withPackages(ps: with ps; [ numpy matplotlib pandas ]))
    unstable-small.elixir
    pkgs.ruby_2_5 pkgs.gcc
    pkgs.file pkgs.binutils
    pkgs.calibre pkgs.kitty

    pkgs.i3-gaps pkgs.dmenu pkgs.compton pkgs.feh pkgs.maim

    unstable-small.jetbrains-mono unstable-small.google-fonts

    pkgs.google-chrome
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

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
    };
    config = {
      "bar/bottom" = {
        modules-left = "date";
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
    };
    script = ''
      polybar top &
    '';
  };

  # services.polybar.override = {
  #   i3GapsSupport = true;
  #   # alsaSupport = true;
  #   # iwSupport = true;
  #   # githubSupport = true;
  # };
}
