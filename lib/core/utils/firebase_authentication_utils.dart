
import 'package:evently/core/constants/services/snackbar_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/services/local_storage_keys.dart';
import '../constants/services/local_storage_services.dart';
import '../routes/page_routes_name.dart';

abstract class FirebaseAuthenticationUtils {
  static Future<bool> createUserWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final _ = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
      // log(credential.user!.uid);
      SnackbarService.showSuccessNotification("Created Successfully");
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackbarService.showErrorNotification(
          e.message ?? "Something Went Wrong",
        );
      } else if (e.code == 'email-already-in-use') {
        SnackbarService.showErrorNotification(
          e.message ?? "Something Went Wrong",
        );
      }
      return Future.value(false);
    } catch (e) {
      // SnackbarService.showErrorNotification("Something Went Wrong");
      return Future.value(false);
    }
  }

  static Future<bool> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final _ = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      SnackbarService.showSuccessNotification("Login Successfully");
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackbarService.showErrorNotification(
          e.message ?? "Something Went Wrong",
        );
      } else if (e.code == 'wrong-password') {
        SnackbarService.showErrorNotification(
          e.message ?? "Something Went Wrong",
        );
      }
      return Future.value(false);
    } catch (e) {
      // SnackbarService.showErrorNotification("Something Went Wrong");
      return Future.value(false);
    }
  }
  static Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return false; // user canceled
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      SnackbarService.showSuccessNotification("Login with Google Successfully");
      return true;
    } catch (e) {
      SnackbarService.showErrorNotification("Google Sign-In Failed");
      return false;
    }
  }


}
