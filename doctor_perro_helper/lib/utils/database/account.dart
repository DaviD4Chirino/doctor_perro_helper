import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/user_account.dart';
import 'package:doctor_perro_helper/models/user_role.dart';
import 'package:flutter/foundation.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

/// Updates the account in the database
/// WARNING: does not check if they exist
Future<DocumentReference?> login(String uid) async {
  try {
    final DocumentReference doc = getDocument("users", uid);
    final DocumentSnapshot snap = await getDocument("users", uid).get();

    UserDocument account =
        UserDocument.fromJson(snap.data() as Map<String, dynamic>);
    account.loginTime = DateTime.timestamp();
    await doc.set(account.toJson());

    return doc;
  } catch (e) {
    if (kDebugMode) {
      print("Error getting document: $e");
    }
  }
  return null;
}

/// creates the account
/// WARNING: does not check if they already exist
Future<DocumentReference> createAccount(UserDocument account) async {
  var newAcc = account
    ..creationTime = DateTime.timestamp()
    ..role = UserRole.employee;

  await db.collection("users").doc(newAcc.uid).set(newAcc.toJson());
  return getDocument("users", newAcc.uid);
}

Future<bool> hasDocument(String collectionPath, String docPath) async {
  final CollectionReference collection = db.collection(collectionPath);
  final DocumentReference doc = collection.doc(docPath);
  final DocumentSnapshot user = await doc.get();

  return user.exists;
}

DocumentReference getDocument(String collectionPath, String docPath) =>
    db.collection(collectionPath).doc(docPath);
