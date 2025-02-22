import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/user_account.dart';
import 'package:doctor_perro_helper/utils/database/account.dart';
import 'package:doctor_perro_helper/utils/google/google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "user.g.dart";

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  User? build() {
    return null;
  }

  void setUser(User user) {
    state = user;
  }

  /// Pops up the Sign In With Google and on successful returns true
  /// and automatically updates the [state].
  Future<void> googleSignIn() async {
    try {
      UserCredential? credentials = await signInWithGoogle();
      User? user = credentials?.user;
      await handleAccountLoginAndDatabase(user);
      state = user;
    } catch (e) {
      if (kDebugMode) {
        print("ERROR ON -> $e");
      }
    }
  }

  Future<void> googleSignOut() async {
    await signOutWithGoogle();
    state = null;
  }

  Future<void> silentlySignIn() async {
    try {
      UserCredential? userCredential = await silentSignInWithGoogle();

      User? user = userCredential?.user;

      await handleAccountLoginAndDatabase(user);

      state = userCredential?.user;
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
/// also updates te database.
Future<void> handleAccountLoginAndDatabase(User? user) async {
  if (await hasDocument("users", user?.uid ?? "no-id")) {
    await login(user?.uid as String);
  } else {
    // dont look at me
    DocumentReference acc = await createAccount(
      UserDocument(
        displayName: user?.displayName as String,
        email: user?.email as String,
      )..uid = user?.uid as String,
    );
    await login(acc.id);
  }
}
