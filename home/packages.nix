{ pkgs, inputs, ... }:

{

  home.packages =  with pkgs; [
    exa # better ls
    bat # better cat
  ];

}
