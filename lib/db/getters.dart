import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remainder/models/categories.dart';
import 'package:remainder/models/tasks.dart';

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

Future<List<Tasks>> getTasks(
    CollectionReference tasksRef, String categoryId) async {
  List<Tasks> tasks = [];
  final docs = await tasksRef.where("categoryId", isEqualTo: categoryId).get();
  for (DocumentSnapshot doc in docs.docs) {
    if (doc.exists) {
      final data = doc.data();
      if (data != null) {
        tasks.add(Tasks.fromJSON({...(data as Map), "id": doc.id}));
      }
    }
  }
  return tasks;
}
