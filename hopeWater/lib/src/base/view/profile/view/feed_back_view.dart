import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hopewater/resources/resources.dart';
import 'package:hopewater/src/base/view/profile/view_model/profile_vm.dart';
import 'package:hopewater/utilis/global_button.dart';
import 'package:hopewater/utilis/global_widget.dart';
import 'package:hopewater/utilis/heights_width.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UserFeedBackView extends StatefulWidget {
  static String route = "/userFeedBack";
  const UserFeedBackView({super.key});

  @override
  State<UserFeedBackView> createState() => _UserFeedBackViewState();
}

class _UserFeedBackViewState extends State<UserFeedBackView> {
  TextEditingController feedbackController = TextEditingController();
  FocusNode feedBackNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileVM>(
      builder: (context, pvm, child) => Scaffold(
        backgroundColor: R.colors.primraryTextColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              GlobalWidget(
                  title: "Feed Back",
                  description:
                      "Please give us your feedback so we can improve our services",
                  onpress: () {
                    Get.back();
                  }),
              h5,
              feedBackTextFormField(),
              h5,
              GlobalButton(
                  isLoading: pvm.loading,
                  height: 7.h,
                  title: "Submit",
                  color: R.colors.splashColor,
                  onpress: () {
                    pvm.submitFeedback(feedbackController.text);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget feedBackTextFormField() {
    return TextFormField(
      maxLines: 4,
      style: R.textStyle.googleFontsPoppins(
          weight: FontWeight.w400,
          size: 12.sp,
          decoration: TextDecoration.none,
          color: R.colors.black),
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: feedbackController,
      focusNode: feedBackNode,
      decoration: R.fieldDecoration.decoration(
          borderColor: R.colors.lightGray,
          textStyle: R.textStyle.googleFontsPoppins(
              weight: FontWeight.w400,
              size: 12.sp,
              decoration: TextDecoration.none,
              color: R.colors.black.withOpacity(.5)),
          hint: 'FeedBack...',
          radius: 15,
          filled: true,
          textInput: TextInputAction.newline,
          fillcolor: R.colors.primraryTextColor),
    );
  }
}
