{ config, pkgs, ... }:

{
  # Time zone
  time.timeZone = "Europe/London";

  # Localization
  i18n.defaultLocale = "en_GB.UTF-8";

  # Console keymap
  console.keyMap = "uk";

  # X11 keymap (still used by some applications)
  services.xserver.xkb.layout = "gb";

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];
}
