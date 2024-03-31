{
  config,
  lib,
  inputs,
  ...
}: {
  # https://dougie.io/linux/hidpi-retina-i3wm/
  # add profileExtra if needed

  xresources.properties =  {
    "Xft.dpi" = 192;
    "Xft.autohint" = 0;
    "Xft.lcdfilter" =  "lcddefault";
    "Xft.hintstyle" = "hintfull";
    "Xft.hinting" = 1;
    "Xft.antialias" = 1;
    "Xft.rgba" = "rgb";
  };

  xsession.profileExtra = ''
  '';
}
