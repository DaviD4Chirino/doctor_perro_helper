import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Pops the Google log-in screen and returns the [UserCredential].
Future<UserCredential?> signInWithGoogle() async {
  GoogleSignIn google = GoogleSignIn();

  try {
    GoogleSignInAccount? googleUser = await google.signIn();
    if (googleUser == null) {
      throw Exception('User not logged in');
    }
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
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

/// Silently signs in with Google and returns the [UserCredential].
Future<UserCredential?> silentSignInWithGoogle() async {
  try {
    GoogleSignIn google = GoogleSignIn();
    GoogleSignInAccount? currentUser = await google.signInSilently();
    if (currentUser == null) {
      throw Exception('User not logged in');
    }
    GoogleSignInAuthentication googleAuth = await currentUser.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential;
  } on Exception catch (e) {
    if (kDebugMode) {
      print("Exception \n $e");
    }
    throw Exception('Failed to silently sign in with Google: $e');
  }
}

/// Signs out from Google.
Future<void> signOutWithGoogle() async {
  GoogleSignIn google = GoogleSignIn();
  if (await google.isSignedIn()) {
    await google.disconnect();
    await FirebaseAuth.instance.signOut();
  }
}

/// Checks if the user is signed in with Google.
Future<bool> hasSignedInWithGoogle() => GoogleSignIn().isSignedIn();
