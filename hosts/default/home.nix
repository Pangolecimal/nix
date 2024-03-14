{pkgs, ...}: {
  home.username = "pango";
  home.homeDirectory = "/home/pango";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # (jetbrains.idea-community)
    # blender
    # jdk21
    (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
    brave
    corefonts
    fd
    file
    libreoffice
    ollama
    qemu
    quickemu
    trash-cli
    wezterm
    wget
    xclip
    vlc

    (writeShellScriptBin "custom-system-rebuild" ''
      set -e
      pushd ~/system
      sudo nixos-rebuild switch --flake ~/system#default
      current=$(nixos-rebuild list-generations --no-build-nix | grep current)
      git add . ; git commit -m "default: $current"
      popd
    '')
  ];

  imports = [
    ../common/home.nix
  ];
}
