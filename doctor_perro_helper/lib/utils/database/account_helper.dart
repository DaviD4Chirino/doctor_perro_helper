import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/abstracts/database_paths.dart';
import 'package:doctor_perro_helper/utils/database/document_helper.dart';
import 'package:doctor_perro_helper/models/user_account.dart';
import 'package:doctor_perro_helper/models/user_role.dart';
import 'package:flutter/foundation.dart';

import 'shared.dart';

/// Updates the account in the database
/// WARNING: does not check if they exist
Future<DocumentReference?> login(String uid) async {
  try {
    final DocumentReference doc = getDocument(CollectionsPaths.users, uid);
    final DocumentSnapshot snap =
        await getDocument(CollectionsPaths.users, uid).get();

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

  await db
      .collection(CollectionsPaths.users)
      .doc(newAcc.uid)
      .set(newAcc.toJson());
  return getDocument(CollectionsPaths.users, newAcc.uid);
}
