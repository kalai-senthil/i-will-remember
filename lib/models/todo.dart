class Todo {
  String todo;
  final String id;
  final String categoryId;
  bool completed;
  final DateTime createdAt;
  Todo({
    required this.createdAt,
    required this.id,
    required this.todo,
    required this.categoryId,
    this.completed = false,
  });

  factory Todo.fromJSON(Map data) {
    return Todo(
      createdAt: data['createdAt'],
      id: data['id'],
      completed: data['completed'] ?? false,
      todo: data['todo'],
      categoryId: data['categoryId'],
    );
  }
  static Map toJSON(Todo todo) {
    return {
      "createdAt": todo.createdAt,
      "id": todo.id,
      "completed": todo.completed,
      "task": todo.todo,
      "categoryId": todo.categoryId,
    };
  }
}
