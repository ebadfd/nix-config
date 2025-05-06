{ config, lib, pkgs, vars, ... }:

{
  imports = import (./modules);

  aerospace.enable = true;

  environment = {
    systemPackages = with pkgs; [
    ];
  };

  homebrew = {
    casks = [
      "postman"
    ];
    masApps = {
      "Keynote" = 409183694;
    };
  };

  system = {
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.trackpad.enableSecondaryClick" = true;
        # "com.apple.keyboard.fnState" = true;
      };
      dock = {
        autohide = true;
        autohide-delay = 0.2;
        autohide-time-modifier = 0.1;
        magnification = true;
        mineffect = "scale";
        # minimize-to-application = true;
        orientation = "bottom";
        showhidden = false;
        show-recents = false;
        tilesize = 20;
      };
      finder = {
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
      };
      magicmouse = {
        MouseButtonMode = "TwoButton";
      };

      CustomUserPreferences = {
        # Settings of plist in ~/Library/Preferences/
        "com.apple.finder" = {
          # Set home directory as startup window
          NewWindowTargetPath = "file:///Users/${vars.user}/";
          NewWindowTarget = "PfHm";
          # Set search scope to directory
          FXDefaultSearchScope = "SCcf";
          # Multi-file tab view
          FinderSpawnTab = true;
        };
        "com.apple.desktopservices" = {
          # Disable creating .DS_Store files in network an USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        # Show battery percentage
        "~/Library/Preferences/ByHost/com.apple.controlcenter".BatteryShowPercentage = true;
        # Privacy
        "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
      };
      CustomSystemPreferences = {
        # ~/Library/Preferences/
      };
    };
  };

  home-manager.users.${vars.user} = {
    programs = lib.mkIf (config.programs.zsh.enable) {
      zsh = {
        initContent = ''
          export HELLO_WORLD="hello"
        '';
      };
    };
  };
}
