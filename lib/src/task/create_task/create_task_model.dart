class CreateTask {
  late String title;

  CreateTask(this.title, this.description, this.date);

  late String description;
  late DateTime date;

  Map<String, dynamic> toJSON() {
    return {
      'title': title,
      'description': description,
      'date':date.toString(),
    };
  }
}
