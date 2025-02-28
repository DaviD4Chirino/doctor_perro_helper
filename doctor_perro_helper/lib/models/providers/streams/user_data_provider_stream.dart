import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/abstracts/database_paths.dart';
import 'package:doctor_perro_helper/models/providers/user.dart';
import 'package:doctor_perro_helper/models/user_account.dart';
import 'package:doctor_perro_helper/utils/database/account_helper.dart';
import 'package:doctor_perro_helper/utils/database/document_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.read(firebaseAuthProvider).authStateChanges();
});

final userDataProvider = StreamProvider<UserData>((ref) async* {
  final authState = await ref.watch(authStateChangesProvider.future);

  if (authState == null) {
    throw Exception('User not logged in');
  }
  try {
    DocumentReference docRef = await handleAccountLoginAndDatabase(authState);
    yield* docRef.snapshots().map((docSnap) {
      Object? data = docSnap.data();
      if (data == null) {
        throw Exception('Document data is null');
      }
      return UserData(
        credential: null,
        document: UserDocument.fromJson(data as Map<String, dynamic>),
        user: authState,
      );
    });
  } catch (e) {
    throw Exception('Failed to fetch user data: $e');
  }
});
Future<DocumentReference> handleAccountLoginAndDatabase(User user) async {
  if (await hasDocument("users", user.uid)) {
    DocumentReference doc = await login(user.uid) as DocumentReference;
    return doc;
  } else {
    // dont look at me
    DocumentReference doc = await createAccount(
      UserDocument(
        displayName: user.displayName as String,
        email: user.email as String,
        uid: user.uid,
      ),
    );
    await login(user.uid);

    return doc;
  }
}
