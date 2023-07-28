import 'package:cloud_firestore/cloud_firestore.dart';

Future<DocumentReference> addRemainderToDB(
    CollectionReference reference, Map<String, dynamic> data) async {
  final docRef = await reference.add(data);
  return docRef;
}

Future<DocumentReference> updateDoc(
    DocumentReference doc, Map<String, dynamic> data) async {
  await doc.update(data);
  return doc;
}
