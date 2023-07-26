class Tasks {
  final String task;
  final String id;
  final String categoryId;
  final bool status;
  final DateTime createdAt;
  Tasks({
    required this.createdAt,
    required this.id,
    required this.status,
    required this.task,
    required this.categoryId,
  });

  factory Tasks.fromJSON(Map data) {
    return Tasks(
      createdAt: data['createdAt'],
      id: data['id'],
      status: data['status'],
      task: data['task'],
      categoryId: data['categoryId'],
    );
  }
}
