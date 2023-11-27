{ pkgs, inputs, ... }:

{

  home.packages =  with pkgs; [
    eza # better ls
    bat # better cat
  ];

}
