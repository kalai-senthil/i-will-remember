import 'package:remainder/models/remainder.dart';
import 'package:remainder/models/todo.dart';

class CalendarWiseView {
  final bool isRemainder;
  final Remainder? remainder;
  final Todo? todo;
  CalendarWiseView(
      {required this.isRemainder, required this.remainder, required this.todo});
  factory CalendarWiseView.fromJSON(Map data) {
    return CalendarWiseView(
      isRemainder: data['isRemainder'],
      remainder: data['remainder'],
      todo: data['todo'],
    );
  }
}
