import 'package:cloud_firestore/cloud_firestore.dart';

import 'shared.dart';

Future<bool> hasDocument(String collectionPath, String docPath) async {
  final CollectionReference collection = db.collection(collectionPath);
  final DocumentReference doc = collection.doc(docPath);
  final DocumentSnapshot snapshot = await doc.get();

  return snapshot.exists;
}

DocumentReference getDocument(String collectionPath, String docPath) =>
    getCollection(collectionPath).doc(docPath);

CollectionReference getCollection(String collectionPath) =>
    db.collection(collectionPath);
