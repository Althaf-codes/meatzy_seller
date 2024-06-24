import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meatzy/Service/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screen/MainHomePage.dart';
import '../Utils/showOTP_dialog.dart';
import '../Utils/snackbar.dart';
import '../Widget/toggle.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  Future<bool?> phoneSignIn(
    BuildContext context, {
    required String phoneNumber,
  }) async {
    TextEditingController codeController = TextEditingController();

    if (kIsWeb) {
      try {
        print('its in kIsWeb');
        ConfirmationResult confirmationResult =
            await _auth.signInWithPhoneNumber(phoneNumber);
        showOTPDialog(
            context: context,
            codeController: codeController,
            onPressed: () async {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: confirmationResult.verificationId,
                  smsCode: codeController.text.trim());
              try {
                await _auth
                    .signInWithCredential(credential)
                    .then((value) => Navigator.pop(context))
                    .then((value) {
                  return true;
                });
              } on FirebaseAuthException catch (e) {
                Navigator.pop(context);
                showSnackBar(context, e.message.toString());
              }
              // await _auth.signInWithCredential(credential).then((value) {
              //   Navigator.pop(context);
              //   if (value != null && value != '') {
              //     authService.signUpUser(
              //         context: context,
              //         phoneNumber: phoneNumber,
              //         password: password,
              //         userName: userName);
              //   } else {
              //     showSnackBar(context, 'Enter a valid OTP');
              //   }
              // });
            });
        //  return true;
      } on FirebaseAuthException catch (e) {
        showSnackBar(context, 'snackbar error msg :${e.message.toString()}');
        return false;
      }
    }

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          showSnackBar(context, e.message.toString());
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        codeSent: (String verificationId, int? forceResendingToken) async {
          showOTPDialog(
              context: context,
              codeController: codeController,
              onPressed: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: codeController.text.trim());

                // await _auth.signInWithCredential(credential);
                // Navigator.pop(context);
                try {
                  await _auth.signInWithCredential(credential).then((value) {
                    Navigator.pop(context);
                  }).then((value) {
                    return true;
                  });
                } on FirebaseAuthException catch (e) {
                  Navigator.pop(context);
                  showSnackBar(context, e.message.toString());
                }
              });
          // notifyListeners();
        },
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      return false;
    }
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      showSnackBar(
          context, e.message!); // Displaying the usual firebase error message
    }
  }

  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent!');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Display error message
    }
  }

  // EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!user.emailVerified) {
        await sendEmailVerification(context);
        // restrict access to certain things using provider
        // transition to another page instead of home screen
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');

        await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
          // Create a new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();

      Navigator.pushNamedAndRemoveUntil(
          context, Toggle.route, (route) => false);
      //  notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }
}
