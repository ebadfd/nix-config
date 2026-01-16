{
  # https://nix-community.github.io/nixvim/plugins/orgmode.html
  programs.nixvim = {
    plugins.orgmode = {
      enable = true;
      settings = {
        org_agenda_files = "~/org/**/*";
        org_default_notes_file = "~/org/refile.org";
        org_deadline_warning_days = 5;
        org_agenda_start_on_weekday = 7;
        org_todo_keywords = [
          "TODO(t)"
          "REVIEW(r)"
          "|"
          "DONE(d)"
          "CANCELLED(c)"
        ];
        org_highlight_latex_and_related = "native";
        highlight = {
          additional_vim_regex_highlighting = [ "org" ];
        };
        #mappings = {
        #  org = {
        #    org_next_visible_heading = "g}";
        #org_previous_visible_heading = "g{";
        #};
        #};
        notifications = {
          enabled = true;
          cron_notifier.__raw = ''
            function(tasks)
              for _, task in ipairs(tasks) do
                local title = string.format('%s (%s)', task.category, task.humanized_duration)
                local subtitle = string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title)
                local date = string.format('%s: %s', task.type, task.time:to_string())

                if vim.fn.executable('notify-send') == 1 then
                  vim.system({
                    'notify-send',
                    '--app-name=orgmode',
                    '--urgency=critical',
                    title,
                    string.format('%s\n%s', subtitle, date),
                  })
                end
              end
            end
          '';
        };
        org_agenda_custom_commands = {
          a = {
            description = "Agenda";
            types = [
              {
                type = "tags";
                match = "REVISIT";
                org_agenda_overriding_header = "Tasks to revisit";
              }
              {
                type = "agenda";
              }
            ];
          };
        };
        org_capture_templates = {
          t = {
            description = "Refile'";
            template = "* TODO %?\nDEADLINE: %T";
          };
          r = {
            description = "Quick note";
            template = "* TODO %? :REVISIT:";
          };
          w = {
            description = "Work todo";
            template = "* TODO %?\nDEADLINE: %T";
            target = "~/org/work.org";
          };
          i = {
            description = "Thoughts";
            template = "** %?";
            target = "~/org/life.org";
            headline = "Thoughts";
          };
          n = {
            description = "Random note";
            template = "* %?";
          };
        };
      };
    };
  };
}
