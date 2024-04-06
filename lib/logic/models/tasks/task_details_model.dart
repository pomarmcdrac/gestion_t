class TaskDetails {
  final int id;
  final String title;
  final int isCompleted;
  final String dueDate;
  final String comments;
  final String description;
  final String tags;
  final String token;
  final String createdAt;
  final String updatedAt;

  TaskDetails({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.dueDate,
    required this.comments,
    required this.description,
    required this.tags,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TaskDetails.fromJson(Map<String, dynamic> json) {
    return TaskDetails(
      id: json['id'],
      title: json['title'],
      isCompleted: json['is_completed'],
      dueDate: json['due_date'],
      comments: json['comments'],
      description: json['description'],
      tags: json['tags'],
      token: json['token'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}