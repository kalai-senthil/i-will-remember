class Remainder {
  final String task;
  final String id;
  final String categoryId;
  final String tone;
  bool enabled;
  final List days;
  final int alarmId;
  final DateTime createdAt;
  final DateTime time;
  Remainder({
    required this.createdAt,
    required this.tone,
    required this.days,
    required this.id,
    required this.enabled,
    required this.task,
    required this.categoryId,
    required this.time,
    required this.alarmId,
  });

  factory Remainder.fromJSON(Map data) {
    return Remainder(
      createdAt: data['createdAt'],
      tone: data['tone'] ?? "assets/alarm.pm3",
      id: data['id'],
      enabled: data['enabled'] ?? false,
      task: data['task'] ?? '',
      days: data['days'],
      categoryId: data['categoryId'],
      time: data['time'],
      alarmId: data['alarmId'] ?? 0,
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
