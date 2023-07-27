import 'package:cloud_firestore/cloud_firestore.dart';

Future<DocumentReference> addTaskToDB(
    CollectionReference reference, Map<String, dynamic> data) async {
  final docRef = await reference.add(data);
  return docRef;
}
