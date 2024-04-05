
List<Task> tasksFromJson(List<dynamic> json) {
  return json.map((task) => Task.fromJson(task)).toList();
}

class Task {
  final int id;
  final String title;
  final int isCompleted;
  final String dueDate;

  Task({
    required this.id, 
    required this.title, 
    required this.isCompleted, 
    required this.dueDate
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      isCompleted: json['is_completed'],
      dueDate: json['due_date'],
    );
  }
}