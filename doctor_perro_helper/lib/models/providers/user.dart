import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_perro_helper/models/user_account.dart';
import 'package:doctor_perro_helper/utils/database/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "user.g.dart";

FirebaseFirestore db = FirebaseFirestore.instance;

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
    GoogleSignIn google = GoogleSignIn();

    try {
      GoogleSignInAccount? googleUser = await google.signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;

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

      state = userCredential.user;
      if (kDebugMode) {
        print("Signup and database updated");
      }
    } catch (e) {
      // String extractedErrorMessage = extractErrorMessage(e);
      if (kDebugMode) {
        print("Exception \n $e");
      }
    }
  }

  Future<void> googleSignOut() async {
    GoogleSignIn google = GoogleSignIn();
    if (await google.isSignedIn()) {
      await google.disconnect();
    }
    state = null;
  }

  Future<void> silentlySignIn() async {
    GoogleSignIn google = GoogleSignIn();
    try {
      GoogleSignInAccount? currentUser = await google.signInSilently();
      GoogleSignInAuthentication? googleAuth =
          await currentUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;

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

      state = userCredential.user;
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
