{ pkgs, ... }:
{
  services.picom = {
    enable = true;
    backend = "xrender";

    fade = false;
    shadow = false;
  };
}
