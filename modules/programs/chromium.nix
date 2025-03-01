{ pkgs, vars, ... }:
let 
  defaultProfile = {
    DefaultBrowserSettingEnabled = false;
    DnsOverHttpsMode = "automatic";
    DnsOverHttpsTemplatesWithIdentifiers  =  "https://cloudflare-dns.com/dns-query https://dns.quad9.net/dns-query{?dns}";
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
      theme = {
        color_variant = 1;
        user_color = -15653309; #181b23
      };
    };
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
  chromePackage = pkgs.ungoogled-chromium;
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
          sha256 = "sha256:0ycnkna72n969crgxfy2lc1qbndjqrj46b9gr5l9b7pgfxi5q0ll";
          version = "1.62.0";
        })
        (createChromiumExtension {
          id = bitwardenExtensionId;
          sha256 = "sha256:1vsvswam4bz0j1sc7ig0xnysshjwj4x7nnzlic711jasf5c3sg3p";
          version = "2025.2.1";
        })
      ];
    };

   home.file = {
      ".config/chromium/Default/Preferences".text = builtins.toJSON personalPreferences;
      ".config/chromium/Profile 1/Preferences".text = builtins.toJSON workPreferences;
    };
  };

  environment  = {
    etc = {
      "/chromium/policies/managed/default.json".text = builtins.toJSON defaultProfile;
      "/chromium/policies/managed/extra.json".text = builtins.toJSON extraOpts;
      "/chromium/policies/recommended/recommended_policies.json".text = builtins.toJSON recommendedOpts;
    };
  };
}
