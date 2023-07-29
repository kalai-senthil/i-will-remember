class Remainder {
  final String task;
  final String id;
  final String categoryId;
  bool enabled;
  final List days;
  final DateTime createdAt;
  Remainder({
    required this.createdAt,
    required this.days,
    required this.id,
    required this.enabled,
    required this.task,
    required this.categoryId,
  });

  factory Remainder.fromJSON(Map data) {
    return Remainder(
      createdAt: data['createdAt'],
      id: data['id'],
      enabled: data['enabled'] ?? false,
      task: data['task'],
      days: data['days'],
      categoryId: data['categoryId'],
    );
  }
  static Map toJSON(Remainder remainder) {
    return {
      "createdAt": remainder.createdAt,
      "id": remainder.id,
      "status": remainder.enabled,
      "task": remainder.task,
      "categoryId": remainder.categoryId,
    };
  }
}
