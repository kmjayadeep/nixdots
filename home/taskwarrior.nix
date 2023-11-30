{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # terminal ui for taskwarrior
    vit
  ];

  # Enable taskwarrior
  programs.taskwarrior = {
    enable = true;
    config = {
      data.location = "~/private/psuite/todo";
      uda.reviewed.type = "date";
      uda.reviewed.label= "Reviewed";
      report._reviewed.description = "Tasksh review report.  Adjust the filter to your needs.";
      report._reviewed.columns = "uuid";
      report._reviewed.sort = "reviewed+,modified+";
      report._reviewed.filter = "( reviewed.none: or reviewed.before:now-6days ) and ( +PENDING or +WAITING )";
      context.ct.read = "project:ct";
      context.ct.write = "project:ct";
      context.avesha.read= "project:avesha";
      context.avesha.write= "project:avesha";
      context.nowork.read= "project.isnt:ct project.isnt:avesha project.isnt:vmo";
      context.nooffice.read= "project.isnt:ct";


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

