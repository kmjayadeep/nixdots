{
  config,
  lib,
  inputs,
  ...
}: {
  home.sessionVariables = {
    PSUITE_NOTES_DIR = "$HOME/private/psuite/notes";
    PSUITE_MINDMAP_DIR = "$HOME/private/psuite/mindmap";
  };
}
