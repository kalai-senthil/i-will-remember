import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:remainder/models/calwise_view.dart';
import 'package:remainder/models/categories.dart';
import 'package:remainder/models/remainder.dart';
import 'package:remainder/models/todo.dart';

Future<List<TaskCategory>> getCategories(
    CollectionReference categoriesRef, String userId) async {
  List<TaskCategory> categories = [];
  final docs = await categoriesRef.where("userId", isEqualTo: userId).get();
  for (DocumentSnapshot doc in docs.docs) {
    if (doc.exists) {
      final data = doc.data();
      if (data != null) {
        categories.add(TaskCategory.fromJSON({...(data as Map), "id": doc.id}));
      }
    }
  }
  return categories;
}

Future<List<Remainder>> getRemainders(
    CollectionReference tasksRef, String categoryId) async {
  List<Remainder> tasks = [];
  final docs = await tasksRef
      .where("categoryId", isEqualTo: categoryId)
      .orderBy("enabled")
      .orderBy("createdAt", descending: true)
      .get();
  for (DocumentSnapshot doc in docs.docs) {
    if (doc.exists) {
      final data = (doc.data() ?? {}) as Map;
      data['createdAt'] = data['createdAt'].toDate();
      if (data.isNotEmpty) {
        tasks.add(Remainder.fromJSON({...data, "id": doc.id}));
      }
    }
  }
  return tasks;
}

Future<Map<String, List<CalendarWiseView>>> getCalendarWiseView(
    CollectionReference remaindersRef,
    CollectionReference todosRef,
    String userId,
    DateTime date) async {
  final inMonth = [
    Timestamp.fromDate(date),
    Timestamp.fromDate(
        DateTime(date.year, date.month + 1).subtract(const Duration(days: 1)))
  ];
  Map<String, List<CalendarWiseView>> cals = {};
  QuerySnapshot docs = await todosRef
      .where("userId", isEqualTo: userId)
      .where("completed", isEqualTo: false)
      .where("createdAt", isGreaterThan: inMonth[0])
      .where("createdAt", isLessThan: inMonth[1])
      .orderBy("createdAt")
      .get();

  for (DocumentSnapshot doc in docs.docs) {
    if (doc.exists) {
      final data = (doc.data() ?? {}) as Map;
      if (data.isNotEmpty) {
        data['createdAt'] = data['createdAt'].toDate();
        Todo todo = Todo.fromJSON({...data, "id": doc.id});
        final key = formatDate(data['createdAt'], [dd]);
        final calWiseView = CalendarWiseView.fromJSON(
          {
            "isRemainder": false,
            "todo": todo,
          },
        );
        if (cals.containsKey(key)) {
          cals[key]!.add(calWiseView);
        } else {
          cals.putIfAbsent(key, () => [calWiseView]);
        }
      }
    }
  }
  docs = await remaindersRef
      .where("userId", isEqualTo: userId)
      .where("enabled", isEqualTo: true)
      .where("createdAt", whereIn: inMonth)
      .where("time", isGreaterThan: inMonth[0])
      .where("time", isLessThan: inMonth[1])
      .get();
  for (DocumentSnapshot doc in docs.docs) {
    if (doc.exists) {
      final data = (doc.data() ?? {}) as Map;
      if (data.isNotEmpty) {
        data['createdAt'] = data['createdAt'].toDate();
        Remainder remainder = Remainder.fromJSON({...data, "id": doc.id});
        final key = formatDate(data['createdAt'], [dd]);
        final calWiseView = CalendarWiseView.fromJSON(
          {
            "isRemainder": false,
            "todo": remainder,
          },
        );
        if (cals.containsKey(key)) {
          cals[key]!.add(calWiseView);
        } else {
          cals.putIfAbsent(
              formatDate(data['createdAt'], [dd]), () => [calWiseView]);
        }
      }
    }
  }
  return cals;
}

Future<List<Todo>> getTodos(
    CollectionReference todosRef, String categoryId) async {
  List<Todo> todos = [];
  final docs = await todosRef
      .where("categoryId", isEqualTo: categoryId)
      .orderBy("completed")
      .orderBy("createdAt", descending: true)
      .get();
  for (DocumentSnapshot doc in docs.docs) {
    if (doc.exists) {
      final data = (doc.data() ?? {}) as Map;
      data['createdAt'] = data['createdAt'].toDate();
      if (data.isNotEmpty) {
        todos.add(Todo.fromJSON({...data, "id": doc.id}));
      }
    }
  }
  return todos;
}
