{
  inputs,
  pkgs,
  vars,
  ...
}:
let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
  searchEngines = {
    "bing".metaData.hidden = true;
    "ebay".metaData.hidden = true;
    "amazondotcom-us".metaData.hidden = true;
    "wikipedia".metaData.hidden = true;

    "ddg" = {
      icon = "https://duckduckgo.com/favicon.ico";
      definedAliases = [ "@ddg" ];
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

    "youtube" = {
      icon = "https://youtube.com/favicon.ico";
      updateInterval = 24 * 60 * 60 * 1000;
      definedAliases = [ "@yt" ];
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

    "google" = {
      icon = "https://www.google.com/favicon.ico";
      definedAliases = [ "@ggl" ];
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
      definedAliases = [ "@np" ];
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
      definedAliases = [ "@no" ];
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
      icon = "https://sourcegraph.com/.assets/img/sourcegraph-mark.svg";
      definedAliases = [ "@sg" ];

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
      icon = "https://github.com/favicon.ico";
      updateInterval = 24 * 60 * 60 * 1000;
      definedAliases = [ "@gh" ];

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
      definedAliases = [ "@hm" ];

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
  settings = {
    "content.notify.interval" = 100000;
    "gfx.canvas.accelerated.cache-items" = 4096;
    "gfx.canvas.accelerated.cache-size" = 512;
    "gfx.content.skia-font-cache-size" = 20;
    "browser.cache.jsbc_compression_level" = 3;
    "media.memory_cache_max_size" = 65536;
    "media.cache_readahead_limit" = 7200;
    "media.cache_resume_threshold" = 3600;
    "image.mem.decode_bytes_at_a_time" = 32768;
    "network.http.max-connections" = 1800;
    "network.http.max-persistent-connections-per-server" = 10;
    "network.http.max-urgent-start-excessive-connections-per-host" = 5;
    "network.http.pacing.requests.enabled" = false;
    "network.dnsCacheExpiration" = 3600;
    "network.ssl_tokens_cache_capacity" = 10240;
    "network.dns.disablePrefetch" = true;
    "network.dns.disablePrefetchFromHTTPS" = true;
    "network.prefetch-next" = false;
    "network.predictor.enabled" = false;
    "network.predictor.enable-prefetch" = false;
    "layout.css.grid-template-masonry-value.enabled" = true;
    "dom.enable_web_task_scheduling" = true;
    "dom.security.sanitizer.enabled" = true;
    "browser.contentblocking.category" = "strict";
    "urlclassifier.trackingSkipURLs" = "*.reddit.com = *.twitter.com = *.twimg.com = *.tiktok.com";
    "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com = *.twitter.com = *.twimg.com";
    "network.cookie.sameSite.noneRequiresSecure" = true;
    "browser.download.start_downloads_in_tmp_dir" = true;
    "browser.helperApps.deleteTempFileOnExit" = true;
    "browser.uitour.enabled" = false;
    "privacy.globalprivacycontrol.enabled" = true;
    "security.OCSP.enabled" = 0;
    "security.remote_settings.crlite_filters.enabled" = true;
    "security.pki.crlite_mode" = 2;
    "security.ssl.treat_unsafe_negotiation_as_broken" = true;
    "browser.xul.error_pages.expert_bad_cert" = true;
    "security.tls.enable_0rtt_data" = false;
    "browser.privatebrowsing.forceMediaMemoryCache" = true;
    "browser.sessionstore.interval" = 60000;
    "privacy.history.custom" = true;
    "browser.urlbar.trimHttps" = true;
    "browser.search.separatePrivateDefault.ui.enabled" = true;
    "browser.urlbar.update2.engineAliasRefresh" = true;
    "browser.search.suggest.enabled" = false;
    "browser.urlbar.quicksuggest.enabled" = false;
    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
    "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
    "browser.urlbar.groupLabels.enabled" = false;
    "browser.formfill.enable" = false;
    "security.insecure_connection_text.enabled" = true;
    "security.insecure_connection_text.pbmode.enabled" = true;
    "network.IDN_show_punycode" = true;
    "dom.security.https_first" = true;
    "dom.security.https_first_schemeless" = true;
    "signon.formlessCapture.enabled" = false;
    "signon.privateBrowsingCapture.enabled" = false;
    "network.auth.subresource-http-auth-allow" = 1;
    "editor.truncate_user_pastes" = false;
    "security.mixed_content.block_display_content" = true;
    "pdfjs.enableScripting" = false;
    "extensions.postDownloadThirdPartyPrompt" = false;
    "network.http.referer.XOriginTrimmingPolicy" = 2;
    "privacy.userContext.ui.enabled" = true;
    "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
    "media.peerconnection.ice.default_address_only" = true;
    "browser.safebrowsing.downloads.remote.enabled" = false;
    "permissions.default.desktop-notification" = 2;
    "permissions.default.geo" = 2;
    "permissions.manager.defaultsUrl" = "";
    "webchannel.allowObject.urlWhitelist" = "";
    "datareporting.policy.dataSubmissionEnabled" = false;
    "datareporting.healthreport.uploadEnabled" = false;
    "toolkit.telemetry.unified" = false;
    "toolkit.telemetry.enabled" = false;
    "toolkit.telemetry.server" = "data: =";
    "toolkit.telemetry.archive.enabled" = false;
    "toolkit.telemetry.newProfilePing.enabled" = false;
    "toolkit.telemetry.shutdownPingSender.enabled" = false;
    "toolkit.telemetry.updatePing.enabled" = false;
    "toolkit.telemetry.bhrPing.enabled" = false;
    "toolkit.telemetry.firstShutdownPing.enabled" = false;
    "toolkit.telemetry.coverage.opt-out" = true;
    "toolkit.coverage.opt-out" = true;
    "toolkit.coverage.endpoint.base" = "";
    "browser.newtabpage.activity-stream.feeds.telemetry" = false;
    "browser.newtabpage.activity-stream.telemetry" = false;
    "app.shield.optoutstudies.enabled" = false;
    "app.normandy.enabled" = false;
    "app.normandy.api_url" = "";
    "breakpad.reportURL" = "";
    "browser.tabs.crashReporting.sendReport" = false;
    "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
    "captivedetect.canonicalURL" = "";
    "network.captive-portal-service.enabled" = false;
    "network.connectivity-service.enabled" = false;
    "dom.private-attribution.submission.enabled" = false;
    "browser.privatebrowsing.vpnpromourl" = "";
    "extensions.getAddons.showPane" = false;
    "extensions.htmlaboutaddons.recommendations.enabled" = false;
    "browser.discovery.enabled" = false;
    "browser.shell.checkDefaultBrowser" = false;
    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
    "browser.preferences.moreFromMozilla" = false;
    "browser.tabs.tabmanager.enabled" = false;
    "browser.aboutConfig.showWarning" = false;
    "browser.aboutwelcome.enabled" = false;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "browser.compactmode.show" = true;
    "browser.display.focus_ring_on_anything" = true;
    "browser.display.focus_ring_style" = 0;
    "browser.display.focus_ring_width" = 0;
    "layout.css.prefers-color-scheme.content-override" = 2;
    "browser.privateWindowSeparation.enabled" = false;
    "cookiebanners.service.mode" = 1;
    "cookiebanners.service.mode.privateBrowsing" = 1;
    "full-screen-api.transition-duration.enter" = "0 0";
    "full-screen-api.transition-duration.leave" = "0 0";
    "full-screen-api.warning.delay" = -1;
    "full-screen-api.warning.timeout" = 0;
    "browser.urlbar.suggest.calculator" = true;
    "browser.urlbar.unitConversion.enabled" = true;
    "browser.urlbar.trending.featureGate" = false;
    "browser.newtabpage.activity-stream.feeds.topsites" = false;
    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
    "extensions.pocket.enabled" = false;
    "browser.download.always_ask_before_handling_new_types" = true;
    "browser.download.manager.addToRecentDocs" = false;
    "browser.download.open_pdf_attachments_inline" = true;
    "browser.bookmarks.openInTabClosesMenu" = false;
    "browser.menu.showViewImageInfo" = true;
    "findbar.highlightAll" = true;
    "layout.word_select.eat_space_to_next_word" = false;
  };
in
{

  home-manager.users.${vars.user} = {
    programs = {
      firefox = {
        enable = true;
        languagePacks = [
          "si"
          "en-US"
        ];

        profiles = {
          "${vars.user}" = {
            id = 0;
            name = "${vars.user}";
            isDefault = true;
            search = {
              force = true;
              default = "ddg";
              order = [
                "ddg"
                "youtube"
                "Google"
                "NixOS Options"
                "Nix Packages"
                "GitHub"
                "HackerNews"
              ];

              engines = searchEngines;
            };
            extensions =
              with (
                if pkgs.stdenv.isDarwin then
                  inputs.firefox-addons.packages."aarch64-darwin"
                else
                  inputs.firefox-addons.packages."x86_64-linux"
              ); [
                bitwarden
                ublock-origin
                surfingkeys
              ];
            inherit settings;
          };
          "${vars.user}-work" = {
            id = 1;
            name = "${vars.user}-work";
            isDefault = false;
            userChrome = ''
              :root {
                --work-red: #b91c1c;
                --work-red-dark: #7f1d1d;
                --work-red-bg: #1a0b0b;
              }

              #navigator-toolbox {
                background-color: var(--work-red-bg) !important;
              }

              #urlbar-background {
                background-color: var(--work-red-bg) !important;
              }
            '';
            search = {
              force = true;
              default = "ddg";
              order = [
                "ddg"
                "youtube"
                "google"
                "NixOS Options"
                "Nix Packages"
                "GitHub"
                "HackerNews"
              ];

              engines = searchEngines;
            };
            extensions =
              with (
                if pkgs.stdenv.isDarwin then
                  inputs.firefox-addons.packages."aarch64-darwin"
                else
                  inputs.firefox-addons.packages."x86_64-linux"
              ); [
                bitwarden
                ublock-origin
                surfingkeys
              ];
            inherit settings;
          };
        };

        # Check about:policies#documentation for options.
        policies = {
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          EnableTrackingProtection = {
            Value = true;
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
          FirefoxSuggest = {
            WebSuggestions = true;
            SponsoredSuggestions = false;
            ImproveSuggest = false;
            Locked = true;
          };
          PasswordManagerEnabled = false;
          PopupBlocking = {
            Default = false;
            Locked = true;
          };
          # ---- PREFERENCES ----
          # Check about:config for options.
          Preferences = {
            "sidebar.verticalTabs" = true;
            "browser.privatebrowsing.vpnpromourl" = "";
            "extensions.getAddons.showPane" = lock-false;
            "extensions.htmlaboutaddons.recommendations.enabled" = lock-false;
            "browser.discovery.enabled" = lock-false;

            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = lock-false;
            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = lock-false;

            "browser.preferences.moreFromMozilla" = lock-false;

            "browser.aboutConfig.showWarning" = lock-false;
            "browser.profiles.enabled" = lock-false;

            # PREF: enable Firefox to use userChome, userContent, etc.
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.compactmode.show" = true;

            # PREF: preferred color scheme for websites
            # [SETTING] General>Language and Appearance>Website appearance
            # By default, color scheme matches the theme of your browser toolbar (3).
            # Set this pref to choose Dark on sites that support it (0) or Light (1).
            # Before FF95, the pref was 2, which determined site color based on OS theme.
            # Dark (0), Light (1), System (2), Browser (3) [DEFAULT FF95+]
            # [1] https://www.reddit.com/r/firefox/comments/rfj6yc/how_to_stop_firefoxs_dark_theme_from_overriding/hoe82i5/?context=3
            "layout.css.prefers-color-scheme.content-override" = {
              Value = 2;
            };

            # PREF: remove fullscreen delay
            "full-screen-api.transition-duration.enter" = "0 0";
            "full-screen-api.transition-duration.leave" = "0 0";

            "browser.urlbar.trimHttps" = lock-true;
            "browser.urlbar.untrimOnUserInteraction.featureGate" = lock-true;

            # PREF: display "Not Secure" text on HTTP sites
            # Needed with HTTPS-First Policy; not needed with HTTPS-Only Mode.
            "security.insecure_connection_text.enabled" = lock-true;
            "security.insecure_connection_text.pbmode.enabled" = lock-true;

            "browser.search.separatePrivateDefault.ui.enabled" = lock-true;

            # PREF: disable fullscreen notice
            "full-screen-api.warning.delay" = -1;
            "full-screen-api.warning.timeout" = 0;

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
            "network.IDN_show_punycode" = lock-true;

            "editor.truncate_user_pastes" = lock-false;
            "pdfjs.enableScripting" = lock-false;
            "network.http.referer.XOriginTrimmingPolicy" = {
              Value = 2;
              status = "locked";
            };

            "browser.contentblocking.category" = {
              Value = "strict";
              Status = "locked";
            };
            "extensions.pocket.enabled" = lock-false;
            "extensions.screenshots.disabled" = lock-true;
            "browser.topsites.contile.enabled" = lock-false;
            "browser.formfill.enable" = lock-false;
            "browser.search.suggest.enabled" = lock-false;
            "browser.search.suggest.enabled.private" = lock-false;
            "browser.urlbar.suggest.searches" = lock-false;

            "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
            "browser.search.update" = lock-false;
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
            "toolkit.telemetry.server" = "data:,";
            "toolkit.telemetry.archive.enabled" = lock-false;
            "toolkit.telemetry.newProfilePing.enabled" = lock-false;
            "toolkit.telemetry.shutdownPingSender.enabled" = lock-false;
            "toolkit.telemetry.updatePing.enabled" = lock-false;
            "toolkit.telemetry.bhrPing.enabled" = lock-false;
            "toolkit.telemetry.firstShutdownPing.enabled" = lock-false;
            "toolkit.telemetry.dap_enabled" = lock-false;

            "toolkit.telemetry.coverage.opt-out" = lock-true;
            "toolkit.coverage.opt-out" = lock-true;
            "toolkit.coverage.endpoint.base" = "";

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
