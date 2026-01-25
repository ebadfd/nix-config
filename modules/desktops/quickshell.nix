{
  config,
  lib,
  pkgs,
  vars,
  ...
}:

with lib;
let
  quickshellDeps = with pkgs; [
    accountsservice
    brightnessctl
    cliphist
    ddcutil
    elogind
    glib
    gsettings-desktop-schemas
    material-symbols
    swww
    wl-clipboard
    wget
  ] ++ (with pkgs.kdePackages; [
    qtbase
    qtdeclarative
    qt6ct
    qtmultimedia
    qtwayland
    kirigami
  ]);

  quickshellWrapped = pkgs.runCommand "quickshell-wrapped" {
    buildInputs = [ pkgs.makeWrapper ];
  } ''
    mkdir -p $out/bin
    paths="${pkgs.lib.makeBinPath quickshellDeps}"
    qmlPaths="${lib.makeSearchPath "lib/qt-6/qml" quickshellDeps}:${lib.makeSearchPath "lib/qt-5/qml" quickshellDeps}"

    for bin in ${pkgs.quickshell}/bin/*; do
      name=$(basename "$bin")
      makeWrapper "$bin" "$out/bin/$name" \
        --prefix QML2_IMPORT_PATH : "$qmlPaths" \
        --prefix PATH : "$paths"
    done
  '';
in
{
  config = mkIf (config.quickshell.enable) {
    environment.systemPackages = with pkgs; [
      quickshellWrapped
      fuzzel
      matugen
      gsettings-desktop-schemas
    ] ++ (with pkgs.kdePackages; [
      qt6ct
    ]);
  };
}
