import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hopewater/resources/resources.dart';
import 'package:hopewater/src/auth/view_model/auth_vm.dart';
import 'package:hopewater/src/base/view_model/base_vm.dart';
import 'package:hopewater/utilis/auth_text.dart';
import 'package:hopewater/utilis/field_validations.dart';
import 'package:hopewater/utilis/global_button.dart';
import 'package:hopewater/utilis/global_widget.dart';
import 'package:hopewater/utilis/heights_width.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SignUpViewScreen extends StatefulWidget {
  static String route = "/signup";
  const SignUpViewScreen({super.key});

  @override
  State<SignUpViewScreen> createState() => _SignUpViewScreenState();
}

class _SignUpViewScreenState extends State<SignUpViewScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  FocusNode phoneNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode nameNode = FocusNode();
  bool _obsecureConfirmPassword = true;
  bool _obsecurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthVM, BaseVM>(
        builder: (context, authVm, baseVm, child) => Scaffold(
              backgroundColor: R.colors.primraryTextColor,
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlobalWidget(
                        title: 'Create Your Account ',
                        description:
                            "Please fill in your details to create your \naccount",
                        onpress: () {
                          Get.back();
                        },
                      ),
                      commonText('Name'),
                      nameTextFormField(),
                      h2,
                      commonText('Phone Number'),
                      phoneTextFormField(),
                      h2,
                      commonText("Email"),
                      emailTextFormField(),
                      h2,
                      commonText("Password"),
                      passwordTextFormField(),
                      h2,
                      commonText("Confirm Password"),
                      confirmPasswordTextFormField(),
                      h2,
                      GlobalButton(
                        height: 7.h,
                        title: 'Sign Up',
                        color: R.colors.splashColor,
                        isLoading: authVm.isLoadingSignUp,
                        onpress: () {
                          if (_formKey.currentState!.validate()) {
                            authVm.signUp(emailController, passwordController,
                                nameController, phoneController);
                          }
                        },
                        fontColor: R.colors.primraryTextColor,
                      ),
                      h1,
                      Center(
                          child: AuthText(
                              title: "Already have an account?",
                              description: "Sign in",
                              onpress: () {
                                Get.back();
                              })),
                      h2
                    ],
                  ),
                ),
              ),
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
        textInputAction: TextInputAction.next,
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

  Widget nameTextFormField() {
    return TextFormField(
        autocorrect: true,
        textCapitalization: TextCapitalization.words,
        style: R.textStyle.googleFontsPoppins(
            weight: FontWeight.w400,
            size: 12.sp,
            decoration: TextDecoration.none,
            color: R.colors.secondaryTextColor),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        obscureText: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return FieldValidator.validateFullName(value);
        },
        controller: nameController,
        focusNode: nameNode,
        decoration: R.fieldDecoration.decoration(
            borderColor: R.colors.black,
            textStyle: R.textStyle.googleFontsPoppins(
                weight: FontWeight.w400,
                size: 12.sp,
                decoration: TextDecoration.none,
                color: R.colors.secondaryTextColor),
            hint: 'Name',
            radius: 15,
            filled: true,
            fillcolor: R.colors.primraryTextColor));
  }

  Widget passwordTextFormField() {
    return TextFormField(
        style: R.textStyle.googleFontsPoppins(
            weight: FontWeight.w400,
            size: 12.sp,
            decoration: TextDecoration.none,
            color: R.colors.secondaryTextColor),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _obsecurePassword,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return FieldValidator.validatePassword(value);
        },
        controller: passwordController,
        focusNode: passwordNode,
        decoration: R.fieldDecoration.decoration(
            suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _obsecurePassword = !_obsecurePassword;
                  });
                },
                child: Icon(_obsecurePassword
                    ? Icons.remove_red_eye_outlined
                    : Icons.visibility_off)),
            borderColor: R.colors.black,
            textStyle: R.textStyle.googleFontsPoppins(
                weight: FontWeight.w400,
                size: 12.sp,
                decoration: TextDecoration.none,
                color: R.colors.secondaryTextColor),
            hint: 'password',
            radius: 15,
            filled: true,
            fillcolor: R.colors.primraryTextColor));
  }

  Widget confirmPasswordTextFormField() {
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
        keyboardType: TextInputType.visiblePassword,
        obscureText: _obsecureConfirmPassword,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return FieldValidator.validatePasswordMatch(
              passwordController.text, value);
        },
        controller: confirmPasswordController,
        focusNode: confirmPasswordNode,
        decoration: R.fieldDecoration.decoration(
            suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _obsecureConfirmPassword = !_obsecureConfirmPassword;
                  });
                },
                child: Icon(_obsecureConfirmPassword
                    ? Icons.remove_red_eye_outlined
                    : Icons.visibility_off)),
            borderColor: R.colors.black,
            textStyle: R.textStyle.googleFontsPoppins(
                weight: FontWeight.w400,
                size: 12.sp,
                decoration: TextDecoration.none,
                color: R.colors.secondaryTextColor),
            hint: 'password',
            radius: 15,
            filled: true,
            fillcolor: R.colors.primraryTextColor));
  }

  Widget phoneTextFormField() {
    return TextFormField(
        style: R.textStyle.googleFontsPoppins(
            weight: FontWeight.w400,
            size: 12.sp,
            decoration: TextDecoration.none,
            color: R.colors.secondaryTextColor),
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.phone,
        obscureText: false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return FieldValidator.validatePhoneNumber(value);
        },
        controller: phoneController,
        focusNode: phoneNode,
        decoration: R.fieldDecoration.decoration(
            borderColor: R.colors.black,
            textStyle: R.textStyle.googleFontsPoppins(
                weight: FontWeight.w400,
                size: 12.sp,
                decoration: TextDecoration.none,
                color: R.colors.secondaryTextColor),
            hint: 'Phone',
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
