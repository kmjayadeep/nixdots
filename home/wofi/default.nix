{
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs.wofi = {
    enable = true;
    settings = {
      ## General
      show="drun";
      prompt="Apps";
      normal_window=tr20;
      layer="top";
      term="foot";

      ## Geometry
      width="500px";
      height="305px";
      location="0";
      orientation="vertical";
      halign="fill";
      line_wrap="off";
      dynamic_lines=false;

      ## Images
      allow_markup=true;
      allow_images=true;
      image_size=24;

      ## Search
      exec_search=false;
      hide_search=false;
      parse_search=false;
      insensitive=false;

      ## Other
      hide_scroll=true;
      no_actions=true;
      sort_order="default";
      gtk_dark=true;
      filter_rate=100;

      ## Keys
      key_expand="Tab";
      key_exit="Escape";
    };
    style = ''
      ${builtins.readFile ./style.css}
    '';
  };
}