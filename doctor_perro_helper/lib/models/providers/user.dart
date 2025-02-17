import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  Future<void> signInWithGoogle() async {
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

      state = userCredential.user;
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
