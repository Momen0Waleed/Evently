import 'dart:math';

import 'package:evently/core/constants/services/snackbar_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthenticationUtils {
  static Future<bool> createUserWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
      // log(credential.user!.uid);
      SnackbarService.showSuccessNotification("Created Successfully");
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        SnackbarService.showErrorNotification(
          e.message ?? "Something Went Wrong",
        );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        SnackbarService.showErrorNotification(
          e.message ?? "Something Went Wrong",
        );
      }
      return Future.value(false);
    } catch (e) {
      print(e);
      // SnackbarService.showErrorNotification("Something Went Wrong");
      return Future.value(false);
    }
  }

  static Future<bool> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      SnackbarService.showSuccessNotification("Login Successfully");
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        SnackbarService.showErrorNotification(
          e.message ?? "Something Went Wrong",
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        SnackbarService.showErrorNotification(
          e.message ?? "Something Went Wrong",
        );
      }
      return Future.value(false);
    } catch (e) {
      print(e);
      // SnackbarService.showErrorNotification("Something Went Wrong");
      return Future.value(false);
    }
  }
}
