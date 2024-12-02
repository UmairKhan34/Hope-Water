import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hopewater/services/session_controller.dart';
import 'package:hopewater/src/auth/view_model/auth_vm.dart';
import 'package:hopewater/src/base/view/profile/view/feed_back_view.dart';
import 'package:hopewater/src/base/view/profile/view_model/profile_vm.dart';
import 'package:hopewater/utilis/global_button.dart';
import 'package:hopewater/utilis/heights_width.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../resources/resources.dart';

class ProfileSettingView extends StatefulWidget {
  static String route = "/profileView";
  const ProfileSettingView({super.key});

  @override
  State<ProfileSettingView> createState() => _ProfileSettingViewState();
}

class _ProfileSettingViewState extends State<ProfileSettingView> {
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref('User');
    return Consumer2<AuthVM, ProfileVM>(
      builder: (context, authVm, profileVm, child) => Scaffold(
        backgroundColor: R.colors.primraryTextColor.withOpacity(1),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              h3,
              StreamBuilder(
                stream:
                    ref.child(SessionController().userId.toString()).onValue,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: R.colors.black,
                        strokeWidth: 1,
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data.snapshot.value;
                    if (data == null) {
                      return Center(
                        child: Text(
                          'No data available',
                          style: R.textStyle.googleFontsPoppins(
                            color: R.colors.black,
                            size: 25.sp,
                          ),
                        ),
                      );
                    }
                    Map<dynamic, dynamic> map = data;
                    return showUserDetail(map, authVm, profileVm);
                  } else {
                    return Center(
                      child: Text(
                        'Something went wrong',
                        style: R.textStyle.googleFontsPoppins(
                          color: R.colors.black,
                          size: 35.sp,
                        ),
                      ),
                    );
                  }
                },
              ),
              h2,
              GlobalButton(
                height: 5.h,
                width: 35.w,
                title: "LogOut",
                color: R.colors.lightGray,
                isLoading: authVm.isLoadingSignUp,
                onpress: () {
                  authVm.signOut();
                },
              ),
              h2,
              GlobalButton(
                height: 5.h,
                width: 35.w,
                title: "Delete Account",
                color: R.colors.splashColor,
                isLoading: authVm.isLoadingSignUp,
                onpress: () {
                  profileVm.showDeleteDialog(context, authVm);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showUserDetail(dynamic map, AuthVM authVm, ProfileVM profileVm) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 3.5.w),
                child: Container(
                  height: 25.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: R.colors.black),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: profileVm.image == null
                        ? map['profile'].toString().isEmpty
                            ? const Icon(
                                Icons.person,
                                size: 35,
                              )
                            : Image.network(
                                map['profile'],
                                fit: BoxFit.cover,
                                width: 55.w,
                                height: 25.h,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: R.colors.black,
                                      strokeWidth: 1,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Icon(
                                      Icons.error_outline_outlined,
                                      color: R.colors.lightGray,
                                    ),
                                  );
                                },
                              )
                        : Image.file(
                            File(profileVm.image!.path).absolute,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  profileVm.pickImage(context);
                },
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: R.colors.lightGray,
                  child: const Icon(
                    Icons.add,
                  ),
                ),
              ),
            ],
          ),
          h3,
          showEmailPassword("Name", map['userName'], () {}),
          divider(),
          showEmailPassword("Email", map['email'], () {}),
          divider(),
          showEmailPassword(
            "Phone",
            map['Phone Number'] == '' ? 'xxx-xxx-xx' : map['Phone Number'],
            () {},
          ),
          divider(),
          showEmailPassword("Password", map['password'], () {}),
          divider(),
          ListTile(
            title: Text(
              'FeedBack',
              style: R.textStyle.googleFontsPoppins(
                  size: 12.sp, color: R.colors.black, weight: FontWeight.w400),
            ),
            trailing: Icon(
              Icons.feedback,
              size: 25,
              color: R.colors.black.withOpacity(.3),
            ),
            onTap: () {
              Get.toNamed(UserFeedBackView.route);
            },
          ),
          divider(),
        ],
      ),
    );
  }

  Widget divider() {
    return Divider(
      color: R.colors.lightGray,
    );
  }

  Widget showEmailPassword(String title, String detail, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: R.textStyle.googleFontsPoppins(
          color: R.colors.black,
          size: 12.sp,
          weight: FontWeight.w400,
        ),
      ),
      trailing: Text(
        detail,
        style: R.textStyle.googleFontsPoppins(
          color: R.colors.black,
          size: 9.sp,
          weight: FontWeight.w400,
        ),
      ),
    );
  }
}
