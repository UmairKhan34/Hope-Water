import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class BaseVM extends ChangeNotifier {
  final databaseRef = FirebaseDatabase.instance.ref("User");
  User? user = FirebaseAuth.instance.currentUser;

  // void userDetail(
  //   TextEditingController nameController,
  //   TextEditingController emailController,
  //   TextEditingController passwordController,
  // ) {
  //   databaseRef
  //       .child(DateTime.now().millisecondsSinceEpoch.toString())
  //       .set({
  //         'name': nameController.text.toString(),
  //         'email': emailController.text.toString(),
  //         'password': passwordController.text.toString()
  //       })
  //       .then((onValue) {})
  //       .onError((error, stackTrace) {});
  // }

  void update() {
    notifyListeners();
  }
}
