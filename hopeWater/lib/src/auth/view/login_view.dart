import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hopewater/resources/resources.dart';
import 'package:hopewater/src/auth/view/forgot_view.dart';
import 'package:hopewater/src/auth/view/sign_up_view.dart';
import 'package:hopewater/src/auth/view_model/auth_vm.dart';
import 'package:hopewater/utilis/auth_text.dart';
import 'package:hopewater/utilis/field_validations.dart';
import 'package:hopewater/utilis/global_button.dart';
import 'package:hopewater/utilis/global_widget.dart';
import 'package:hopewater/utilis/heights_width.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginViewScreen extends StatefulWidget {
  static String route = "/loginScreen";
  const LoginViewScreen({super.key});

  @override
  State<LoginViewScreen> createState() => _LoginViewScreenState();
}

class _LoginViewScreenState extends State<LoginViewScreen> {
  TextEditingController emailController = TextEditingController();
  FocusNode emailNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordNode = FocusNode();
  bool _obsecure = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVM>(
        builder: (context, authVm, child) => Scaffold(
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
                        title: 'Welcome Back!',
                        description:
                            "Please fill in your email and password to login to your account",
                        onpress: () {
                          Get.back();
                        },
                      ),
                      h7,
                      commonText("Email"),
                      h1,
                      emailTextFormField(),
                      h3,
                      commonText('Password'),
                      h1,
                      passwordTextFormField(),
                      h3,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(ForgotViewScreen.route);
                            },
                            child: Text(
                              'Forgot Password?',
                              style: R.textStyle.googleFontsPoppins(
                                  color: R.colors.black,
                                  size: 12.sp,
                                  weight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      h8,
                      GlobalButton(
                        height: 7.h,
                        title: 'Login',
                        color: R.colors.splashColor,
                        isLoading: authVm.isLoadingLogin,
                        onpress: () {
                          if (_formKey.currentState!.validate()) {
                            authVm.login(emailController, passwordController);
                          }
                        },
                        fontColor: R.colors.primraryTextColor,
                      ),
                      h3,
                      Center(
                          child: AuthText(
                              title: "Don't have an account?",
                              description: "Sign Up",
                              onpress: () {
                                Get.toNamed(SignUpViewScreen.route);
                              }))
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
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _obsecure,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return FieldValidator.validateLoginPassword(value);
        },
        controller: passwordController,
        focusNode: passwordNode,
        decoration: R.fieldDecoration.decoration(
            suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _obsecure = !_obsecure;
                  });
                },
                child: Icon(_obsecure
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

  Widget commonText(String title) {
    return Text(
      title,
      style: R.textStyle.googleFontsPoppins(
          weight: FontWeight.bold, color: R.colors.black, size: 13.sp),
    );
  }
}
