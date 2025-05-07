{ vars, ... }:
{
  home-manager.users.${vars.user} = {
    programs = {
      git = {
        enable = true;

        userName  = vars.user;
        userEmail = vars.email;
        # signing.key = "23F4D4A69DB69784";

        extraConfig = {
          push = { autoSetupRemote = true; };
          commit.gpgsign = true;
        };

        aliases = {
          ci = "commit";
          co = "checkout";
          s = "status";
        };
      };
    };
  };
}
