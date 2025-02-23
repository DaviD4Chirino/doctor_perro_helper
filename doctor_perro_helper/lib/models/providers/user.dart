import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/user_account.dart';
import 'package:doctor_perro_helper/utils/database/account.dart';
import 'package:doctor_perro_helper/utils/google/google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "user.g.dart";

//?: rework this so the credential and document are getters instead of a class
@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  UserData build() {
    return UserData(credential: null, document: null);
  }

  void setUser(UserData user) {
    state = user;
  }

  /// Pops up the Sign In With Google and on successful returns true
  /// and automatically updates the [state].
  Future<void> googleSignIn() async {
    try {
      UserCredential? credentials = await signInWithGoogle();
      User? user = credentials?.user;
      DocumentReference doc = await handleAccountLoginAndDatabase(user);
      var data = await doc.get();

      state = UserData(
        credential: credentials,
        document: UserDocument.fromJson(data.data() as Map<String, dynamic>),
      );
    } catch (e) {
      if (kDebugMode) {
        print("ERROR ON -> $e");
      }
    }
  }

  Future<void> googleSignOut() async {
    await signOutWithGoogle();
    state = UserData(credential: null, document: null);
  }

  Future<void> silentlySignIn() async {
    try {
      UserCredential? credentials = await silentSignInWithGoogle();

      User? user = credentials?.user;

      DocumentReference doc = await handleAccountLoginAndDatabase(user);
      var docGet = await doc.get();

      state = UserData(
        credential: credentials,
        document: UserDocument.fromJson(docGet.data() as Map<String, dynamic>),
      );
    } catch (e) {
      if (kDebugMode) {
        print("Exception \n $e");
      }
    }
  }
}

String extractErrorMessage(dynamic exception) {
  // You can add more specific error handling if needed
  if (exception is FirebaseAuthException) {
    return exception.message ?? "An unknown error occurred.";
  } else if (exception is AssertionError) {
    return exception.message.toString();
  }
  return "An unknown error occurred.";
}

/// This creates an account if theres no document with its uid and logs it in.
/// Also updates te database.
/// Also spits the [DocumentReference] if exist.
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

class UserData {
  UserData({
    required this.credential,
    required this.document,
  });
  bool get isEmpty => credential == null && document == null;

  UserCredential? credential;
  UserDocument? document;

  UserData merge(UserCredential? credential, UserDocument? document) {
    return UserData(
      credential: credential ?? this.credential,
      document: document ?? this.document,
    );
  }
}
