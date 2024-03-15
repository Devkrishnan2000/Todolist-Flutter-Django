class Task {
  late String title;
  late String description;
  late bool completed;
  late DateTime date;
  late DateTime createdDate;
  late int userId;
  late int taskId;

  Task(this.title, this.description, this.completed, this.date,
      this.createdDate);
  Task.fromJSON(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    completed = json['completed'];
    date = DateTime.parse(json['date']);
    createdDate = DateTime.parse(json['created_date']);
    userId = json["user"];
    taskId = json["id"];
  }

  Map<String, dynamic> toJSON() {
    return {
      'title': title,
      'description': description,
      'completed': completed,
      'date': date,
      'created_date': createdDate
    };
  }
}
