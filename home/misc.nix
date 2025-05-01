{
  config,
  lib,
  inputs,
  go-todo-exporter,
  ...
}: {
  home.sessionVariables = {
    PSUITE_NOTES_DIR = "/samba/psuite/psuite-notes";
    PSUITE_MINDMAP_DIR = "/samba/psuite/psuite-mindmap";
  };
}
