{
  config,
  lib,
  vars,
  ...
}:

{
  imports = import (./modules);

  yabai.enable = true;

  system = {
    defaults = {
      # Whether to enable quarantine for downloaded applications. The default is true.
      LaunchServices.LSQuarantine = false;

      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        # Configures the keyboard control behavior. Mode 3 enables full keyboard control.
        AppleKeyboardUIMode = 3;
        AppleICUForce24HourTime = true;

        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        AppleSpacesSwitchOnActivate = true;

        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;

        NSDocumentSaveNewDocumentsToCloud = false;

        NSTableViewDefaultSizeMode = 2;

        # hide the menu bar
        _HIHideMenuBar = true;

        # beep/alert volume
        "com.apple.sound.beep.volume" = 0.000;
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.trackpad.enableSecondaryClick" = true;
        "com.apple.swipescrolldirection" = false;

        # "com.apple.keyboard.fnState" = true;
      };

      alf = {
        globalstate = 1;
        stealthenabled = 1;
      };

      controlcenter = {
        AirDrop = false;
        BatteryShowPercentage = true;
        Display = false;

      };

      dock = {
        autohide = true;
        autohide-delay = 0.2;
        autohide-time-modifier = 0.1;
        magnification = false;
        mineffect = "scale";
        # minimize-to-application = true;
        orientation = "bottom";
        showhidden = false;
        show-recents = false;
        tilesize = 40;
      };

      finder = {
        ShowPathbar = true;
        ShowStatusBar = true;
        AppleShowAllExtensions = true;
        CreateDesktop = false;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        FXRemoveOldTrashItems = true;
        ShowExternalHardDrivesOnDesktop = false;
        ShowHardDrivesOnDesktop = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
      };

      loginwindow = {
        DisableConsoleAccess = true;
        GuestEnabled = false;
      };

      menuExtraClock = {
        IsAnalog = true;
        Show24Hour = true;
        ShowDate = 0;
      };

      screencapture = {
        disable-shadow = true;
      };

      CustomUserPreferences = {
        # Settings of plist in ~/Library/Preferences/
        "com.apple.finder" = {
          # Set home directory as startup window
          NewWindowTargetPath = "file:///Users/${vars.user}/";
          WarnOnEmptyTrash = false;
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
