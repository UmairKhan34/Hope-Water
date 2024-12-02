// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hopewater/src/base/view/profile/view_model/profile_vm.dart';
// import 'package:hopewater/utilis/heights_width.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';

// import '../../../../../resources/resources.dart';

// class LanguageScreenView extends StatefulWidget {
//   static String route = "/languagescreen";
//   const LanguageScreenView({super.key});

//   @override
//   State<LanguageScreenView> createState() => _LanguageScreenViewState();
// }

// class _LanguageScreenViewState extends State<LanguageScreenView> {
//   TextEditingController languageController = TextEditingController();
//   String search = "";
//   @override
//   void dispose() {
//     languageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProfileVM>(
//         builder: (context, profileVm, child) => Scaffold(
//               backgroundColor: R.colors.primraryTextColor,
//               appBar: AppBar(
//                 automaticallyImplyLeading: false,
//                 backgroundColor: R.colors.primraryTextColor,
//                 title: GestureDetector(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: Row(
//                     children: [
//                       Image.asset(
//                         R.images.backButton,
//                         scale: 3.5,
//                       ),
//                       w3,
//                       Text(
//                         'back',
//                         style: R.textStyle.googleFontsPoppins(
//                             weight: FontWeight.w400,
//                             size: 14.sp,
//                             decoration: TextDecoration.none,
//                             color: R.colors.splashColor),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               body: SingleChildScrollView(
//                 padding: EdgeInsets.symmetric(horizontal: 5.w),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     h1,
//                     Text(
//                       'language',
//                       style: R.textStyle.googleFontsPoppins(
//                           weight: FontWeight.bold,
//                           size: 30.sp,
//                           decoration: TextDecoration.none,
//                           color: R.colors.black),
//                     ),
//                     h3,
//                     searchTextFormField(),
//                     SizedBox(
//                       height: 72.h,
//                       child: ListView.builder(
//                           itemCount: profileVm.languageList.length,
//                           itemBuilder: (context, index) {
//                             late String languageName =
//                                 profileVm.languageList[index].languageName ??
//                                     "";

//                             if (languageController.text.isEmpty) {
//                               return Column(
//                                 children: [
//                                   h1,
//                                   ListTile(
//                                     title: Text(
//                                       profileVm.languageList[index]
//                                               .languageName ??
//                                           "",
//                                       style: R.textStyle.googleFontsPoppins(
//                                           weight: FontWeight.w500,
//                                           size: 14.sp,
//                                           decoration: TextDecoration.none,
//                                           color: R.colors.black),
//                                     ),
//                                     subtitle: Text(
//                                       profileVm.languageList[index]
//                                               .englishLanguage ??
//                                           "",
//                                       style: R.textStyle.googleFontsPoppins(
//                                           weight: FontWeight.w400,
//                                           size: 11.sp,
//                                           decoration: TextDecoration.none,
//                                           color:
//                                               R.colors.black.withOpacity(.3)),
//                                     ),
//                                   ),
//                                   Container(
//                                     padding: EdgeInsets.only(left: 5.w),
//                                     child: Divider(
//                                       color: R.colors.black.withOpacity(.2),
//                                       height: 0.5,
//                                       thickness: 0.5,
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             } else if (languageName
//                                     .toLowerCase()
//                                     .contains(languageController.text) ||
//                                 languageName
//                                     .toUpperCase()
//                                     .contains(languageController.text)) {
//                               return Column(
//                                 children: [
//                                   h1,
//                                   ListTile(
//                                     title: Text(
//                                       profileVm.languageList[index]
//                                               .languageName ??
//                                           "",
//                                       style: R.textStyle.googleFontsPoppins(
//                                           weight: FontWeight.w500,
//                                           size: 14.sp,
//                                           decoration: TextDecoration.none,
//                                           color: R.colors.black),
//                                     ),
//                                     subtitle: Text(
//                                       profileVm.languageList[index]
//                                               .englishLanguage ??
//                                           "",
//                                       style: R.textStyle.googleFontsPoppins(
//                                           weight: FontWeight.w400,
//                                           size: 11.sp,
//                                           decoration: TextDecoration.none,
//                                           color:
//                                               R.colors.black.withOpacity(.3)),
//                                     ),
//                                   ),
//                                   Container(
//                                     padding: EdgeInsets.only(left: 5.w),
//                                     child: Divider(
//                                       color: R.colors.black.withOpacity(.2),
//                                       height: 0.5,
//                                       thickness: 0.5,
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             } else {
//                               return const SizedBox();
//                             }
//                           }),
//                     )
//                   ],
//                 ),
//               ),
//             ));
//   }

//   Widget searchTextFormField() {
//     return TextFormField(
//       onTapOutside: (event) {
//         FocusManager.instance.primaryFocus?.unfocus();
//       },
//       controller: languageController,
//       autocorrect: true,
//       keyboardType: TextInputType.text,
//       decoration: R.fieldDecoration.decoration(
//           hint: 'Search',
//           radius: 12,
//           filled: true,
//           suffixIcon: Icon(
//             Icons.mic,
//             color: R.colors.lightGray.withOpacity(.7),
//           ),
//           prefixIcon: Icon(
//             Icons.search,
//             color: R.colors.lightGray.withOpacity(.7),
//           ),
//           fillcolor: R.colors.lightGray.withOpacity(.1),
//           borderColor: R.colors.lightGray.withOpacity(.1)),
//       onChanged: (String? value) {
//         setState(() {
//           search = value.toString();
//         });
//       },
//     );
//   }
// }
