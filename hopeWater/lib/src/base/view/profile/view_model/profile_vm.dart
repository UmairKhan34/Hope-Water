// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hopewater/resources/resources.dart';
import 'package:hopewater/services/session_controller.dart';
import 'package:hopewater/src/auth/view_model/auth_vm.dart';
import 'package:hopewater/utilis/heights_width.dart';
import 'package:hopewater/utilis/toast_message/toast_message.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../model/profile_model.dart';

class ProfileVM extends ChangeNotifier {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("User");
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    update();
  }

  Future pickImageGallery(BuildContext context) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);

      update();
    }
  }

  Future pickCamerImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);

      update();
    }
  }

  LanguageModel model = LanguageModel();
  List<LanguageModel> languageList = [
    LanguageModel(languageName: 'English (US)', englishLanguage: 'English'),
    LanguageModel(languageName: 'Afrikaans', englishLanguage: 'Afrikaans'),
    LanguageModel(
        languageName: 'Bahasa Indonesia', englishLanguage: 'Indonesian'),
    LanguageModel(languageName: 'Bahasa Melayu', englishLanguage: 'Malay'),
    LanguageModel(languageName: 'Dansk', englishLanguage: 'Danish'),
    LanguageModel(languageName: 'Deutsch', englishLanguage: 'German'),
    LanguageModel(languageName: 'English (UK)', englishLanguage: 'English'),
    LanguageModel(languageName: 'Español (España)', englishLanguage: 'Spanish'),
    LanguageModel(
        languageName: 'Español (América Latino)', englishLanguage: 'Spanish'),
    LanguageModel(languageName: 'Filipino', englishLanguage: 'Filipinos'),
    LanguageModel(languageName: 'Français (Canada)', englishLanguage: 'French'),
    LanguageModel(languageName: 'Urdu', englishLanguage: 'urdu'),
  ];
  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(22)),
              height: 17.h,
              child: Column(
                children: [
                  choseCameraGallery("Camera", Icons.camera, () {
                    pickCamerImage(context);
                    Get.back();
                  }),
                  h2,
                  choseCameraGallery("Gallery", Icons.image, () {
                    pickImageGallery(context);
                    Get.back();
                  })
                ],
              ),
            ),
          );
        });
  }

  Widget choseCameraGallery(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 18,
      ),
      title: Text(
        title,
        style:
            R.textStyle.googleFontsPoppins(size: 10.sp, color: R.colors.black),
      ),
    );
  }

  void update() {
    notifyListeners();
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);
    try {
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref('/profileImage${SessionController().userId.toString()}');

      firebase_storage.UploadTask uploadTask =
          storageRef.putFile(File(image!.path).absolute);

      await uploadTask.whenComplete(() => null);
      final newUrl = await storageRef.getDownloadURL();

      ref
          .child(SessionController().userId.toString())
          .update({'profile': newUrl.toString()}).then((value) {
        ToastMessage.toastMessage('Profile Updated', R.colors.black);
        setLoading(false);
        _image = null;
      }).onError((error, stackTrace) {
        setLoading(false);
        ToastMessage.toastMessage(error.toString(), R.colors.black);
      });
    } catch (e) {
      setLoading(false);
      ToastMessage.toastMessage(e.toString(), R.colors.black);
    }
  }

  void showDeleteDialog(BuildContext context, AuthVM authVm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Account',
            style: R.textStyle
                .googleFontsPoppins(size: 12.sp, color: R.colors.black),
          ),
          content: Text('Do you really want to delete your account?',
              style: R.textStyle
                  .googleFontsPoppins(size: 9.sp, color: R.colors.black)),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel',
                  style: R.textStyle
                      .googleFontsPoppins(size: 10.sp, color: R.colors.black)),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final user = authVm.auth.currentUser;
                  if (user != null) {
                    final email = user.email!;
                    final password = await _getPasswordFromUser(context);

                    if (password != null) {
                      final credential = EmailAuthProvider.credential(
                          email: email, password: password);
                      await user.reauthenticateWithCredential(credential);

                      await _deleteUser(context, authVm);
                      authVm.signOut();
                    } else {
                      ToastMessage.toastMessage(
                          "Password is required to delete the account",
                          R.colors.black);
                    }
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'wrong-password') {
                    ToastMessage.toastMessage(
                        "Wrong password. Please try again.", R.colors.black);
                  } else {
                    ToastMessage.toastMessage(
                        "Failed to re-authenticate. Please try again.",
                        R.colors.black);
                  }
                } catch (e) {
                  ToastMessage.toastMessage(
                      "An error occurred. Please try again.", R.colors.black);
                }
              },
              child: Text('Delete',
                  style: R.textStyle
                      .googleFontsPoppins(size: 10.sp, color: R.colors.black)),
            ),
          ],
        );
      },
    );
  }

  Future<String?> _getPasswordFromUser(BuildContext context) async {
    String? password;
    await showDialog(
      context: context,
      builder: (context) {
        final passwordController = TextEditingController();
        return AlertDialog(
          title: const Text('Enter Password'),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                password = passwordController.text;
                Get.back();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
    return password;
  }

  Future<void> submitFeedback(String feedback) async {
    setLoading(true);
    try {
      final userId = SessionController().userId.toString();
      await ref.child(userId).update({'feedBack': feedback});
      ToastMessage.toastMessage('Feedback Submitted', R.colors.black);
      Get.back();
    } catch (e) {
      ToastMessage.toastMessage('Error: ${e.toString()}', R.colors.black);
    } finally {
      setLoading(false);
    }
  }

  Future<void> _deleteUser(BuildContext context, AuthVM authVm) async {
    final userId = SessionController().userId.toString();
    final ref = FirebaseDatabase.instance.ref('User');

    await authVm.deleteUser();
    await ref.child(userId).remove();
    ToastMessage.toastMessage("Account Delete Successfully", R.colors.black);
  }
}
