import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/user_account.dart';
import 'package:doctor_perro_helper/models/user_role.dart';
import 'package:flutter/foundation.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> login(String uid) async {
  try {
    if (await hasDocument("users", uid) == false) {
      log("Does not have the document $uid");
      return;
    }

    final DocumentReference doc = getDocument("users", uid);
    final DocumentSnapshot snap = await getDocument("users", uid).get();

    UserDocument account =
        UserDocument.fromJson(snap.data() as Map<String, dynamic>);
    account.loginTime = DateTime.timestamp();

    await doc.set(account.toJson());
  } catch (e) {
    if (kDebugMode) {
      print("Error getting document: $e");
    }
  }
}

/// creates the account or returns the already existing one
Future<DocumentReference> createAccount(UserDocument account) async {
  if (await hasDocument("users", account.uid)) {
    if (kDebugMode) {
      print("Account already in database");
    }
    return getDocument("users", account.uid);
  } else {
    var newAcc = account
      ..creationTime = DateTime.timestamp()
      ..role = UserRole.employee;

    await db.collection("users").doc(newAcc.uid).set(newAcc.toJson());
    return getDocument("users", newAcc.uid);
  }
}

/// This will check if the account already exist in the database,
/// if not, it will create a new document or else it will log in
Future<void> createAndLoginAccount() async {}

Future<bool> hasDocument(String collectionPath, String docPath) async {
  final CollectionReference collection = db.collection(collectionPath);
  final DocumentReference doc = collection.doc(docPath);
  final DocumentSnapshot user = await doc.get();

  return user.exists;
}

DocumentReference getDocument(String collectionPath, String docPath) =>
    db.collection(collectionPath).doc(docPath);
