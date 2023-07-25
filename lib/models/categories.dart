class TaskCategory {
  final String name;
  final String id;
  TaskCategory({required this.id, required this.name});
  factory TaskCategory.fromJSON(Map data) {
    return TaskCategory(
      id: data['id'],
      name: data['name'],
    );
  }
}
