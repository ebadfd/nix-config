{ inputs, vars, ... }:
  let
    lock-false = {
      Value = false;
      Status = "locked";
    };
    lock-true = {
      Value = true;
      Status = "locked";
    };
  in
{
  home-manager.users.${vars.user} = {
  programs = {
    firefox = {
      enable = true;
      languagePacks = [ "si" "en-US" ];

      profiles.${vars.user} = {

      search = {
        force = true;
        default = "DuckDuckGo";
        order = ["DuckDuckGo" "Youtube" "Google" "NixOS Options" "Nix Packages" "GitHub" "HackerNews"];
      
        engines = {
          "Bing".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "Amazon.com".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;

          "DuckDuckGo" = {
            iconUpdateURL = "https://duckduckgo.com/favicon.ico";
            definedAliases = ["@ddg"];
            urls = [
              {
                template = "https://duckduckgo.com/";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

      
          "YouTube" = {
            iconUpdateURL = "https://youtube.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@yt"];
            urls = [
              {
                template = "https://www.youtube.com/results";
                params = [
                  {
                    name = "search_query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "Google" = {
            iconUpdateURL = "https://www.google.com/favicon.ico";
            definedAliases = ["@ggl"];
            urls = [
              {
                template = "https://www.google.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
      
          "Nix Packages" = {
            icon = "https://nixos.org/favicon.svg";
            definedAliases = ["@np"];
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                  {
                    name = "channel";
                    value = "unstable";
                  }
                ];
              }
            ];
          };
      
          "NixOS Options" = {
            icon = "https://nixos.org/favicon.svg";
            definedAliases = ["@no"];
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
      
          "SourceGraph" = {
            iconUpdateURL = "https://sourcegraph.com/.assets/img/sourcegraph-mark.svg";
            definedAliases = ["@sg"];
      
            urls = [
              {
                template = "https://sourcegraph.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
      
          "GitHub" = {
            iconUpdateURL = "https://github.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@gh"];
      
            urls = [
              {
                template = "https://github.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
      
          "Home Manager" = {
            # icon = "https://nixos.org/_astro/flake-blue.Bf2X2kC4_Z1yqDoT.svg";
            definedAliases = ["@hm"];
      
            url = [
              {
                template = "https://mipmip.github.io/home-manager-option-search/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
        };
      };





        userChrome = ''
#main-window #TabsToolbar > .toolbar-items {
  overflow: hidden;
}
#main-window #TabsToolbar > .toolbar-items { height: 0 !important; }
        '';
        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          bitwarden
          ublock-origin
          sidebery
          surfingkeys
        ];
      };

      # Check about:policies#documentation for options.
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value= true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = false;
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisableFirefoxScreenshots = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
        DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
        SearchBar = "unified"; # alternative: "separate"
        DNSOverHTTPS = {
          Enabled = false;
        };
        PasswordManagerEnabled = false;

        /* ---- PREFERENCES ---- */
        # Check about:config for options.
        Preferences = { 
          "browser.privatebrowsing.vpnpromourl" = "";
          "extensions.getAddons.showPane" = lock-false;
          "extensions.htmlaboutaddons.recommendations.enabled" = lock-false;
          "browser.discovery.enabled" = lock-false;

          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" =  lock-false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" =  lock-false;

          "browser.preferences.moreFromMozilla"= lock-false;

          "browser.aboutConfig.showWarning" =  lock-false;
          "browser.profiles.enabled" = lock-false;

           # PREF: enable Firefox to use userChome, userContent, etc.
          "toolkit.legacyUserProfileCustomizations.stylesheets"= true;
          "browser.compactmode.show" = true;

          # PREF: preferred color scheme for websites
          # [SETTING] General>Language and Appearance>Website appearance
          # By default, color scheme matches the theme of your browser toolbar (3).
          # Set this pref to choose Dark on sites that support it (0) or Light (1).
          # Before FF95, the pref was 2, which determined site color based on OS theme.
          # Dark (0), Light (1), System (2), Browser (3) [DEFAULT FF95+]
          # [1] https://www.reddit.com/r/firefox/comments/rfj6yc/how_to_stop_firefoxs_dark_theme_from_overriding/hoe82i5/?context=3
          "layout.css.prefers-color-scheme.content-override" =  {
            Value = 2;
          };

          # PREF: remove fullscreen delay
          "full-screen-api.transition-duration.enter" =  "0 0"; 
          "full-screen-api.transition-duration.leave" =  "0 0";

          "browser.urlbar.trimHttps" =  lock-true;
          "browser.urlbar.untrimOnUserInteraction.featureGate" =  lock-true;

          # PREF: display "Not Secure" text on HTTP sites
          # Needed with HTTPS-First Policy; not needed with HTTPS-Only Mode.
          "security.insecure_connection_text.enabled" = lock-true;
          "security.insecure_connection_text.pbmode.enabled"=  lock-true;

          "browser.search.separatePrivateDefault.ui.enabled" =  lock-true;

          # PREF: disable fullscreen notice
          "full-screen-api.warning.delay" =  -1;
          "full-screen-api.warning.timeout" =  0;

          "signon.formlessCapture.enabled" = lock-false;
          "signon.privateBrowsingCapture.enabled" = lock-false;

          # PREF: enforce Punycode for Internationalized Domain Names to eliminate possible spoofing
          # Firefox has some protections, but it is better to be safe than sorry.
          # [!] Might be undesirable for non-latin alphabet users since legitimate IDN's are also punycoded.
          # [EXAMPLE] https://www.techspot.com/news/100555-malvertising-attack-uses-punycode-character-spread-malware-through.html
          # [TEST] https://www.xn--80ak6aa92e.com/ (www.apple.com)
          # [1] https://wiki.mozilla.org/IDN_Display_Algorithm
          # [2] https://en.wikipedia.org/wiki/IDN_homograph_attack
          # [3] CVE-2017-5383: https://www.mozilla.org/security/advisories/mfsa2017-02/
          # [4] https://www.xudongz.com/blog/2017/idn-phishing/
          "network.IDN_show_punycode" =  lock-true;


          "editor.truncate_user_pastes" = lock-false;
          "pdfjs.enableScripting" = lock-false;
          "network.http.referer.XOriginTrimmingPolicy" = { Value = 2; status = "locked"; };

          "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
          "extensions.pocket.enabled" = lock-false;
          "extensions.screenshots.disabled" = lock-true;
          "browser.topsites.contile.enabled" = lock-false;
          "browser.formfill.enable" = lock-false;
          "browser.search.suggest.enabled" = lock-false;
          "browser.search.suggest.enabled.private" = lock-false;
          "browser.urlbar.suggest.searches" = lock-false;

          "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
          "browser.search.update"= lock-false;
          "browser.menu.showViewImageInfo" = lock-true;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
          "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
          "browser.newtabpage.activity-stream.feeds.topsites" = lock-false;
          "browser.newtabpage.activity-stream.showWeather" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
          "browser.newtabpage.activity-stream.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;

          "datareporting.policy.dataSubmissionEnabled" = lock-false;
          "datareporting.healthreport.uploadEnabled" = lock-false;
          "toolkit.telemetry.unified" = lock-false;
          "toolkit.telemetry.enabled" = false; 
          "toolkit.telemetry.server" =  "data:,";
          "toolkit.telemetry.archive.enabled" = lock-false;
          "toolkit.telemetry.newProfilePing.enabled" = lock-false;
          "toolkit.telemetry.shutdownPingSender.enabled" = lock-false;
          "toolkit.telemetry.updatePing.enabled" = lock-false;
          "toolkit.telemetry.bhrPing.enabled" = lock-false;
          "toolkit.telemetry.firstShutdownPing.enabled" = lock-false;
          "toolkit.telemetry.dap_enabled" = lock-false; 

          "toolkit.telemetry.coverage.opt-out" = lock-true; 
          "toolkit.coverage.opt-out" = lock-true;
          "toolkit.coverage.endpoint.base" =  "";

          "browser.newtabpage.activity-stream.feeds.telemetry" = lock-false;
          "browser.newtabpage.activity-stream.telemetry" = lock-false;
          "app.shield.optoutstudies.enabled" = lock-false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          "breakpad.reportURL" = "";
          "browser.tabs.crashReporting.sendReport" = lock-false;
        };
      };
    };
  };
  };
}
