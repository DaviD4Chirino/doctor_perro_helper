import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "users_database.g.dart";

FirebaseFirestore db = FirebaseFirestore.instance;

@riverpod
class UsersDatabaseNotifier extends _$UsersDatabaseNotifier {
  Future<void> setUser(
      String userUid, Map<String, dynamic> data, SetOptions? options) async {
    await db.collection("users").doc(userUid).set(data, options);
    state = db.collection("users");
  }

  DocumentReference getUser(String userUid) {
    return db.collection("users").doc(userUid);
  }

  @override
  CollectionReference build() {
    return db.collection("users");
  }
}
