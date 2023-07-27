class Tasks {
  final String task;
  final String id;
  final String categoryId;
  final bool enabled;
  final List days;
  final DateTime createdAt;
  Tasks({
    required this.createdAt,
    required this.days,
    required this.id,
    required this.enabled,
    required this.task,
    required this.categoryId,
  });

  factory Tasks.fromJSON(Map data) {
    return Tasks(
      createdAt: data['createdAt'],
      id: data['id'],
      enabled: data['enabled'] ?? false,
      task: data['task'],
      days: data['days'],
      categoryId: data['categoryId'],
    );
  }
  static Map toJSON(Tasks task) {
    return {
      "createdAt": task.createdAt,
      "id": task.id,
      "status": task.enabled,
      "task": task.task,
      "categoryId": task.categoryId,
    };
  }
}
