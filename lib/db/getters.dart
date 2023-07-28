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

Future<List<Remainder>> getTasks(
    CollectionReference tasksRef, String categoryId) async {
  List<Remainder> tasks = [];
  final docs = await tasksRef.where("categoryId", isEqualTo: categoryId).get();
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
