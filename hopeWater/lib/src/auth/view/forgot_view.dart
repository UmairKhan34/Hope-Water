import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hopewater/src/auth/view_model/auth_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import '../../../utilis/field_validations.dart';
import '../../../utilis/global_button.dart';
import '../../../utilis/global_widget.dart';
import '../../../utilis/heights_width.dart';
class ForgotViewScreen extends StatefulWidget {
  static String route= "/forgotView";
  const ForgotViewScreen({super.key});

  @override
  State<ForgotViewScreen> createState() => _ForgotViewScreenState();
}

class _ForgotViewScreenState extends State<ForgotViewScreen> {
  TextEditingController emailController = TextEditingController();
  FocusNode emailNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

   return Consumer<AuthVM>(builder: (context,authVm,child)=>Scaffold(
       backgroundColor: R.colors.primraryTextColor,

        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalWidget(
                  title: 'Forgot Password',
                  description:
                  "We will sent you email to recover password,\nPlease check email",
                  onpress: () {
                    Get.back();
                  },
                ),
                h5,
                commonText("Email"),
                h1,
                emailTextFormField(),
                h8,
                GlobalButton(
                  height: 7.h,
                  title: 'Forgot',
                  color: R.colors.splashColor,
                  isLoading: authVm.isLoginForgot,
                  onpress: () {
                    if (formKey.currentState!.validate()) {
                      authVm.forgotPassword(emailController);
                    }
                  },
                  fontColor: R.colors.primraryTextColor,
                ),
                h3,

              ],
            ),
          ),
        )
    ));
  }
  Widget emailTextFormField() {
    return TextFormField(
        style: R.textStyle.googleFontsPoppins(
            weight: FontWeight.w400,
            size: 12.sp,
            decoration: TextDecoration.none,
            color: R.colors.secondaryTextColor),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.emailAddress,
        obscureText: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return FieldValidator.validateEmail(value);
        },
        controller: emailController,
        focusNode: emailNode,
        decoration: R.fieldDecoration.decoration(
            borderColor: R.colors.black,
            textStyle: R.textStyle.googleFontsPoppins(
                weight: FontWeight.w400,
                size: 12.sp,
                decoration: TextDecoration.none,
                color: R.colors.secondaryTextColor),
            hint: 'Email',
            radius: 15,
            filled: true,
            fillcolor: R.colors.primraryTextColor));
  }
  Widget commonText(String title) {
    return Text(
      title,
      style: R.textStyle.googleFontsPoppins(
          weight: FontWeight.bold, color: R.colors.black, size: 13.sp),
    );
  }
}
