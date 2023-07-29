import 'package:cloud_firestore/cloud_firestore.dart';
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
