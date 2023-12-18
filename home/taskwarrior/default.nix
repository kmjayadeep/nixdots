{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./todo-exporter.nix
  ];

  home.packages = with pkgs; [
    # terminal ui for taskwarrior
    vit
    # Open task annoted items externally, eg: open urls in browser
    taskopen
  ];

  home.file.".vit/config.ini".source = ./vit-config.ini;

  # Enable taskwarrior
  programs.taskwarrior = {
    dataLocation = "~/private/psuite/todo";
    enable = true;
    config = {
      context.ct.read = "project:ct";
      context.ct.write = "project:ct";
      context.nowork.read = "project.isnt:ct";
      context.nooffice.read = "project.isnt:ct";

      # GTD - get things done: https://nfraprado.net/post/managing-my-tasks-using-vit.html
      # GTD uda config
      uda.folder.type = "string";
      uda.folder.label = "folder";
      uda.folder.default = "in";
      uda.folder.values = "in,todo,cal,backlog,standby,someday";
      # urgency.uda.folder.todo.coefficient = 15
      # urgency.uda.folder.someday.coefficient = -5

      uda.priority.values = "H,L,";
      urgency.uda.priority.H.coefficient = "6.0";
      urgency.uda.priority.L.coefficient = "-6.0";

      uda.difficulty.type = "string";
      uda.difficulty.label = "Difficulty";
      uda.difficulty.values = "H,L,";

      # GTD reports config
      report.next.columns = "id,start.age,priority,project,tags,recur,scheduled.countdown,due.relative,until.remaining,description.count,folder,urgency";
      report.next.labels = "ID,Active,P,Project,Tag,Recur,S,Due,Until,Description,folder,Urg";
      report.next.sort = "folder-/,urgency-";

      "report.in.columns" = "id,description";
      "report.in.description" = "Inbox";
      "report.in.filter" = "status:pending limit:page folder:in";
      "report.in.labels" = "ID,Description";

      report.todo.description = "Next TODO tasks";
      report.todo.columns = "id,start.age,priority,project,tags,recur,scheduled.countdown,due.relative,until.remaining,description.count,folder,urgency";
      report.todo.labels = "ID,Active,P,Project,Tag,Recur,S,Due,Until,Description,folder,Urg";
      report.todo.filter = "status:pending limit: folder:todo";
      report.todo.sort = "urgency-";

      report.backlog.description = "Tasks by project";
      report.backlog.columns = "id,start.age,priority,project,tags,recur,scheduled.countdown,due.relative,until.remaining,description.count,folder,urgency";
      report.backlog.labels = "ID,Active,P,Project,Tag,Recur,S,Due,Until,Description,folder,Urg";
      report.backlog.filter = "status:pending folder.not:someday";
      report.backlog.sort = "project-/,folder-,urgency-";

      report.someday.columns = "id,description.count";
      report.someday.description = "Someday/Maybe";
      report.someday.filter = "limit: folder:someday status:pending";
      report.someday.labels = "ID,Description";
    };
  };
}
