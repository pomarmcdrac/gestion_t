class TaskDetails {
  int? id;
  final String title;
  final int isCompleted;
  final String dueDate;
  String? comments;
  String? description;
  String? tags;
  String? token;
  String? createdAt;
  String? updatedAt;

  TaskDetails({
    this.id,
    required this.title,
    required this.isCompleted,
    required this.dueDate,
    this.comments,
    this.description,
    this.tags,
    this.token,
    this.createdAt,
    this.updatedAt,
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