import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hopewater/resources/resources.dart';
import 'package:hopewater/services/session_controller.dart';
import 'package:hopewater/src/base/view/base_view.dart';
import 'package:hopewater/src/base/view_model/base_vm.dart';
import 'package:hopewater/src/landing/welcome_screen.dart';
import 'package:hopewater/utilis/toast_message/toast_message.dart';

class AuthVM extends ChangeNotifier {
  BaseVM baseVm = BaseVM();
  bool _isLoadingSignUp = false;
  final auth = FirebaseAuth.instance;
  bool _isLoadingForgot = false;
  File? image;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isLoginForgot => _isLoadingForgot;
  bool get isLoadingSignUp => _isLoadingSignUp;

  void _setLoadingSignUp(bool value) {
    _isLoadingSignUp = value;
    notifyListeners();
  }

  bool _isLoadingLogin = false;
  bool get isLoadingLogin => _isLoadingLogin;

  void signOut() async {
    _setLoadingSignUp(true);
    try {
      await _auth.signOut();
      Get.offAllNamed(WelcomeScreen.route);
    } catch (error) {
      ToastMessage.toastMessage(error.toString(), R.colors.black);
    } finally {
      _setLoadingSignUp(false);
    }
  }

  void _setLoadingLogIn(bool value) {
    _isLoadingLogin = value;
    notifyListeners();
  }

  void _setLoadingForgot(bool value) {
    _isLoadingForgot = value;
    notifyListeners();
  }

  void forgotPassword(TextEditingController emailController) async {
    _setLoadingForgot(true);

    try {
      await auth.sendPasswordResetEmail(email: emailController.text);
      ToastMessage.toastMessage(
          "We have sent an email to recover password. Please check your email.",
          R.colors.black);
    } catch (error) {
      ToastMessage.toastMessage(error.toString(), R.colors.black);
    } finally {
      _setLoadingForgot(false);
    }
  }

  void login(TextEditingController emailController,
      TextEditingController passwordController) async {
    _setLoadingLogIn(true);
    try {
      UserCredential value = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      SessionController().userId = value.user!.uid.toString();
      Get.offAllNamed(BaseView.route);
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'invalid-email') {
        message = 'Invalid Email.';
      } else if (e.code == 'wrong-password') {
        message = 'Invalid Password.';
      } else if (e.code == 'user-not-found') {
        message = 'No user found with this email.';
      } else if (e.code == 'user-disabled') {
        message = 'User with this email has been disabled.';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many requests. Try again later.';
      } else {
        message = 'Failed to Login. Please try again.';
      }
      ToastMessage.toastMessage(message, R.colors.black);
    } catch (e) {
      ToastMessage.toastMessage("Failed to Login", R.colors.black);
    } finally {
      _setLoadingLogIn(false);
    }
  }

  final ref = FirebaseDatabase.instance.ref('User');

  void signUp(
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController nameController,
      TextEditingController phoneController) async {
    _setLoadingSignUp(true);

    try {
      UserCredential value = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await ref.child(value.user!.uid.toString()).set({
        'uid': value.user!.uid.toString(),
        'email': value.user!.email.toString(),
        'userName': nameController.text,
        'password': passwordController.text,
        'Phone Number': phoneController.text,
        'profile': '',
        'feedBack': '',
      });

      ToastMessage.toastMessage("Account Created Successfully", R.colors.black);
      signOut();
      Get.back();
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      } else if (e.code == 'weak-password') {
        message = 'The password is too weak.';
      } else {
        message = 'Failed to create an account. Please try again.';
      }
      ToastMessage.toastMessage(message, R.colors.black);
    } catch (e) {
      ToastMessage.toastMessage("Unable to Create account", R.colors.black);
    } finally {
      _setLoadingSignUp(false);
    }
  }

  Future<void> deleteUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.delete();
    }
  }
}
