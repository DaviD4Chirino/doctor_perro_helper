import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Pops the google log in screen and returns the [UserCredential]
Future<UserCredential?> signInWithGoogle() async {
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

    return userCredential;
  } catch (e) {
    // String extractedErrorMessage = extractErrorMessage(e);
    if (kDebugMode) {
      print("Exception \n $e");
    }
  }
  return null;
}

Future<UserCredential?> silentSignInWithGoogle() async {
  try {
    GoogleSignIn google = GoogleSignIn();
    GoogleSignInAccount? currentUser = await google.signInSilently();
    GoogleSignInAuthentication? googleAuth = await currentUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential;
  } on Exception catch (e) {
    log("$e");
  }
  return null;
}

Future<void> signOutWithGoogle() async {
  GoogleSignIn google = GoogleSignIn();
  if (await google.isSignedIn()) {
    await google.disconnect();
  }
}

Future<bool> hasSignedInWithGoogle() => GoogleSignIn().isSignedIn();
