{ pkgs,  lib, vars, ... }:
let 
  defaultProfile = {
    DefaultBrowserSettingEnabled = false;
    DnsOverHttpsMode = "automatic";
    DnsOverHttpsTemplatesWithIdentifiers  =  "https://cloudflare-dns.com/dns-query https://dns.quad9.net/dns-query{?dns}";
    HomepageLocation = "https://homepage.ebadfd.tech/";
    NewTabPageLocation = "https://homepage.ebadfd.tech/";
  };
  recommendedOpts = {
    BrowserThemeColor = "#181b23";
  };

  # Bitwarden Password Manager
  # https://chromewebstore.google.com/detail/bitwarden-password-manage/nngceckbapebfimnlniiiahkandclblb
  bitwardenExtensionId = "nngceckbapebfimnlniiiahkandclblb";

  # uBlock Origin
  # https://chromewebstore.google.com/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm
  ublockOriginExtensionId = "cjpalhdlnbpafiamejdnhcphjbkeiagm";

  # https://chromewebstore.google.com/detail/surfingkeys/gfbliohnnapiefjpjlpjnehglfpaknnc
  surfingkeysExtensionId  = "gfbliohnnapiefjpjlpjnehglfpaknnc";

  # manually disableing webgl seems to fix the issue with youtube video playback.
  # chrome://flags/#disable-webgl
  personalPreferences = {
    partition =  {
      default_zoom_level=  {
        x =  -0.5778829311823857;
      };
    };
    profile = {
      avatar_index =  34;
      name = "Personal";
    };
    browser = {
      has_seen_welcome_page = true;
      theme = {
        color_variant = 1;
        user_color = -15653309; #181b23
      };
    };
    pinned_extensions = [
      bitwardenExtensionId
      ublockOriginExtensionId
    ];
    extensions =  {
      alerts =  {
        initialized =  true;
      };
      partition =  {
        default_zoom_level=  {
          x =  -0.5778829311823857;
        };
      };
      commands =  {
        "linux:Ctrl+Shift+9" =  {
          command_name = "generate_password";
          extension =  bitwardenExtensionId;
          global =  false;
        };
        "linux:Ctrl+Shift+L" =  {
          command_name =  "autofill_login";
          extension =  bitwardenExtensionId;
          global =  false;
        };
        "linux:Ctrl+Shift+U" =  {
          command_name =  "_execute_action";
          extension =  bitwardenExtensionId;
          global =  false;
        };
      };
    };
  };

  workPreferences = {
    partition =  {
      default_zoom_level=  {
        x =  -0.5778829311823857;
      };
    };
    profile = {
      avatar_index =  30;
      name = "Work";
    };
    pinned_extensions = [
      bitwardenExtensionId
      ublockOriginExtensionId
    ];
    browser = {
      has_seen_welcome_page = true;
      theme = {
        color_variant = 1;
        user_color = -806210;
      };
    };
  };

  extraOpts = {
    BrowserSignin = 0; # Disable browser sign-in
    SyncDisabled = true;
    PasswordManagerEnabled = false;
    SpellcheckEnabled = true;
    RestoreOnStartup = 1;
    BookmarkBarEnabled = false;

    # Do not auto import anything
    ImportAutofillFormData = false;
    ImportBookmarks = false;
    ImportHistory = false;
    ImportHomepage = false;
    ImportSavedPasswords = false;
    ImportSearchEngine = false;
    UrlKeyedAnonymizedDataCollectionEnabled = false;

    TranslateEnabled = false;
    AutoplayAllowed = false;
    # Disable tabs with promotions, user help or requests to set Chromium as the default browser
    PromotionalTabsEnabled = false;

    # Do not autofill address and credit card
    AutofillAddressEnabled = false;
    AutofillCreditCardEnabled = false;

    SearchSuggestEnabled = true;
    MetricsReportingEnabled = false;

    CloudReportingEnabled = false;
    CloudProfileReportingEnabled = false;
    CloudExtensionRequestEnabled = false;
    # QuicAllowed = false; # Disallow QUIC protocol 
    HardwareAccelerationModeEnabled = true;

    # AI History Search is a feature that allows users to search their browsing history 
    # and receive generated answers based on page contents and not just the page title and URL.
    # https://chromeenterprise.google/policies/#HistorySearchSettings 
    HistorySearchSettings = 2 ; # Do not allow the feature

    DownloadDirectory = "/tmp";
    DefaultSearchProviderEnabled = true;
    DefaultSearchProviderName = "DuckDuckGo";
    DefaultSearchProviderSearchURL = "https://duckduckgo.com/?q={searchTerms}";
    DefaultSearchProviderImageURL = "https://duckduckgo.com/favicon.ico";

    ClearBrowsingDataOnExitList = [
     "browsing_history"
     "download_history"
      # "cookies_and_other_site_data"
     "cached_images_and_files"
     "password_signin"
     "autofill"
     "site_settings"
     "hosted_app_data"
    ];

    DefaultNotificationsSetting = 2;
    # 1 = Allow sites to show desktop notifications
    # 2 = Do not allow any site to show desktop notifications
    # 3 = Ask every time a site wants to show desktop notifications
  };
  # chromePackage = pkgs.google-chrome;

  chromePackage =
    if pkgs.stdenv.isLinux then
      pkgs.ungoogled-chromium
    else if pkgs.stdenv.isDarwin && pkgs.stdenv.isAarch64 then
      let
        chromiumVersion = "1456749";
        chromium-mac = pkgs.stdenv.mkDerivation rec {
          name = "chromium-bin";
          pname = "Chromium";
          buildInputs = [ pkgs.undmg ];

          # this implementation is based on the following flake
          # https://github.com/lrworth/chromium-bin-flake/blob/master/flake.nix
          
          src = pkgs.fetchzip {
            url = "https://commondatastorage.googleapis.com/chromium-browser-snapshots/Mac_Arm/${chromiumVersion}/chrome-mac.zip";
              hash = "sha256-irv/gea1lZqv2ApV/VdS3tsw6P7nISUnW1VVyWfvjfk=";
          };
              nativeBuildInputs = [ pkgs.makeWrapper ];

              installPhase = ''
                mkdir -p "$out/bin" "$out/Applications"
                mv -t "$out/Applications/" "Chromium.app/"
                makeWrapper "$out/Applications/Chromium.app/Contents/MacOS/Chromium" "$out/bin/${pname}"
              '';

          meta = with pkgs.lib; {
            platforms = [ "aarch64-darwin"];
          };
        };

        wrapped = pkgs.writeShellScriptBin "chromium" ''
          ${chromium-mac}/Chromium.app/Contents/MacOS/Chromium "$@"
        '';
      in pkgs.symlinkJoin {
        name = "chromium-mac-wrapper";
        version = chromiumVersion;
        paths = [ wrapped chromium-mac ];
      }
  else
    throw "Unsupported platform for Chromium";
in
{
  home-manager.users.${vars.user} = {
    programs.chromium = {
      enable = true;
      package = chromePackage;

      extensions = let
        createChromiumExtensionFor = browserVersion: {
          id,
          sha256,
          version,
        }: {
          inherit id;
          crxPath = builtins.fetchurl {
            url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
            name = "${id}.crx";
            inherit sha256;
          };
          inherit version;
        };
        createChromiumExtension = createChromiumExtensionFor (pkgs.lib.versions.major chromePackage.version);
      in [
        (createChromiumExtension {
          id = ublockOriginExtensionId;
          sha256 = "sha256:1lnk0k8zy0w33cxpv93q1am0d7ds2na64zshvbwdnbjq8x4sw5p6";
          version = "1.62.0";
        })
        (createChromiumExtension {
          id = bitwardenExtensionId;
          sha256 = "sha256:1jh3yzyq3gl7d1xjs30wsfgbq493dmx7xdpis2b7p3fadn7jsrix";
          version = "2025.2.1";
        })
        (createChromiumExtension {
          id = surfingkeysExtensionId;
          sha256 = "sha256:04ybl87jglk0v46ksxzfbnx9pdm0m5rgjdshx4mq0lakps1bss5q";
          version = "1.17.7";
        })
        (createChromiumExtension {
          id = surfingkeysExtensionId;
          sha256 = "sha256:04ybl87jglk0v46ksxzfbnx9pdm0m5rgjdshx4mq0lakps1bss5q";
          version = "1.17.7";
        })
      ];
    };

    #  Library/Application\ Support/Google/Chrome/Default 
   home.file = {
      ".config/chromium/Default/Preferences".text = builtins.toJSON personalPreferences;
      ".config/chromium/Profile 1/Preferences".text = builtins.toJSON workPreferences;
    };
  };

  environment.etc = lib.mkIf pkgs.stdenv.isLinux {
    "chromium/policies/managed/default.json".text = builtins.toJSON defaultProfile;
    "chromium/policies/managed/extra.json".text = builtins.toJSON extraOpts;
    "chromium/policies/recommended/recommended_policies.json".text = builtins.toJSON recommendedOpts;
  };

  system.activationScripts.chromePrefs.text = lib.mkIf pkgs.stdenv.isDarwin ''
    mkdir -p /Library/Google/Chrome/ManagedPreferences

    cat > /Library/Google/Chrome/ManagedPreferences/default.json <<EOF
    ${builtins.toJSON defaultProfile}
    EOF

    cat > /Library/Google/Chrome/ManagedPreferences/extra.json <<EOF
    ${builtins.toJSON extraOpts}
    EOF

    cat > /Library/Google/Chrome/ManagedPreferences/recommended_policies.json <<EOF
    ${builtins.toJSON recommendedOpts}
    EOF
  '';
}
