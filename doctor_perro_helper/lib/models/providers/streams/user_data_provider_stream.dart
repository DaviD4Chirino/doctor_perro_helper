import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/abstracts/database_paths.dart';
import 'package:doctor_perro_helper/models/providers/user.dart';
import 'package:doctor_perro_helper/models/user_account.dart';
import 'package:doctor_perro_helper/utils/database/account_helper.dart';
import 'package:doctor_perro_helper/utils/database/document_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.read(firebaseAuthProvider).authStateChanges();
});

final userDataProvider = StreamProvider<UserData>((ref) async* {
  try {
    CollectionReference collection = getCollection(CollectionsPaths.users);
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception('User not logged in');
    }
    DocumentReference docRef = collection.doc(currentUser.uid);

    yield* docRef.snapshots().map((docSnap) {
      Object? data = docSnap.data();
      if (data == null) {
        throw Exception('Document data is null');
      }
      return UserData(
        credential: null,
        document: UserDocument.fromJson(data as Map<String, dynamic>),
      );
    });
  } catch (e) {
    throw Exception('Failed to fetch user data: $e');
  }
});
Future<DocumentReference> handleAccountLoginAndDatabase(User? user) async {
  if (await hasDocument("users", user?.uid ?? "no-id")) {
    DocumentReference doc =
        await login(user?.uid as String) as DocumentReference;
    return doc;
  } else {
    // dont look at me
    DocumentReference doc = await createAccount(
      UserDocument(
        displayName: user?.displayName as String,
        email: user?.email as String,
        uid: user?.uid as String,
      ),
    );
    await login(doc.id);

    return doc;
  }
}
