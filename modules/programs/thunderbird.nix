{ vars, ... }:
{
  home-manager.users.${vars.user} = {
    programs = {
      thunderbird = {
        enable = true;
        profiles.${vars.user} = {
          isDefault = true;
        };
      };
    };
  };
}
