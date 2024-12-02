import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hopewater/resources/resources.dart';
import 'package:hopewater/services/session_controller.dart';
import 'package:hopewater/src/base/view/favourite/view/favourite_view.dart';
import 'package:hopewater/src/base/view_model/base_vm.dart';
import 'package:hopewater/utilis/heights_width.dart';
import 'package:hopewater/utilis/shimmer_effect.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeViewScreen extends StatefulWidget {
  static String route = "/homeView";
  const HomeViewScreen({super.key});

  @override
  State<HomeViewScreen> createState() => _HomeViewScreenState();
}

class _HomeViewScreenState extends State<HomeViewScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref('User');
    final refOffer = FirebaseDatabase.instance.ref('Offers');
    final refItems = FirebaseDatabase.instance.ref('Items');

    return Consumer<BaseVM>(
      builder: (context, baseVm, child) => Scaffold(
        backgroundColor: R.colors.lightGray.withOpacity(.3),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: R.colors.splashColor),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      h10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Welcome Back!',
                            style: R.textStyle.googleFontsPoppins(
                                size: 12.sp,
                                color: R.colors.primraryTextColor,
                                weight: FontWeight.w500),
                          ),
                          PersistentShoppingCart().showCartItemCountWidget(
                              cartItemCountWidgetBuilder: (itemCount) =>
                                  IconButton(
                                      onPressed: () {
                                        Get.toNamed(FavouriteViewScreen.route);
                                      },
                                      icon: Badge(
                                        backgroundColor:
                                            R.colors.primraryTextColor,
                                        label: Center(
                                          child: Text(
                                            itemCount.toString(),
                                            style: R.textStyle
                                                .googleFontsPoppins(
                                                    size: 7.sp,
                                                    color: R.colors.textColor),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.shopping_bag_outlined,
                                          color: R.colors.primraryTextColor,
                                        ),
                                      )))
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                        child: StreamBuilder(
                          stream: ref
                              .child(SessionController().userId.toString())
                              .onValue,
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return ShimmerWidget.rectangular(
                                height: 4.h,
                                width: 15.w,
                              );
                            } else if (snapshot.hasData) {
                              final data = snapshot.data.snapshot.value;
                              if (data == null) {
                                return Text(
                                  'Empty',
                                  style: R.textStyle.googleFontsPoppins(
                                      color: R.colors.black, size: 10.sp),
                                );
                              }
                              Map<dynamic, dynamic> map = data;
                              return userName(map);
                            } else {
                              return Center(
                                child: Text(
                                  'Something went wrong',
                                  style: R.textStyle.googleFontsPoppins(
                                      color: R.colors.black, size: 35.sp),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      h2,
                      searchTextFormField(),
                      h3,
                    ],
                  ),
                ),
              ),
              h2,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0.w),
                child: SizedBox(
                  height: 17.h,
                  width: double.infinity,
                  child: FutureBuilder(
                    future: Future.delayed(const Duration(seconds: 5)),
                    builder: (context, AsyncSnapshot<void> timerSnapshot) {
                      if (timerSnapshot.connectionState !=
                          ConnectionState.done) {
                        return Center(
                          child: ShimmerWidget.rectangular(
                            height: 17.h,
                            width: double.infinity,
                          ),
                        );
                      } else {
                        return StreamBuilder(
                          stream: refOffer.onValue,
                          builder:
                              (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                            if (!snapshot.hasData ||
                                snapshot.data!.snapshot.value == null) {
                              return ShimmerWidget.rectangular(
                                height: 17.h,
                                width: double.infinity,
                              );
                            } else {
                              return viewOffers(snapshot);
                            }
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
              h2,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Water Types",
                      style: R.textStyle.googleFontsPoppins(
                          weight: FontWeight.bold,
                          color: R.colors.black,
                          size: 13.sp),
                    ),
                    SizedBox(
                      height: 50.h,
                      child: StreamBuilder(
                        stream: refItems.onValue,
                        builder:
                            (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                          if (!snapshot.hasData ||
                              snapshot.data!.snapshot.value == null) {
                            return ShimmerWidget.rectangular(
                              height: 10.h,
                              width: double.infinity,
                            );
                          } else {
                            return viewItems(snapshot);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              h5
            ],
          ),
        ),
      ),
    );
  }

  Widget viewOffers(AsyncSnapshot<DatabaseEvent> snapshot) {
    Map<dynamic, dynamic> map =
        snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
    List<dynamic> values = map.values.toList();
    return PageView.builder(
      itemCount: values.length,
      itemBuilder: (context, index) {
        var data = values[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                data['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint(error.toString());
                  return ShimmerWidget.rectangular(
                    height: 17.h,
                    width: double.infinity,
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return ShimmerWidget.rectangular(
                    height: 17.h,
                    width: double.infinity,
                  );
                },
              ),
              w1P5,
            ],
          ),
        );
      },
    );
  }

  Widget viewItems(AsyncSnapshot<DatabaseEvent> snapshot) {
    Map<dynamic, dynamic> map =
        snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
    List<dynamic> values = map.values.toList();

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.w,
        mainAxisSpacing: 5.w,
        childAspectRatio: 0.59,
      ),
      itemCount: values.length,
      itemBuilder: (context, index) {
        var data = values[index];
        return Container(
          decoration: BoxDecoration(
            color: R.colors.primraryTextColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    data['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint(error.toString());
                      return ShimmerWidget.rectangular(
                        height: 10.h,
                        width: double.infinity,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return ShimmerWidget.rectangular(
                        height: 10.h,
                        width: double.infinity,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 6.0.w, vertical: 1.5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title'],
                      style: R.textStyle.googleFontsPoppins(
                        size: 10.sp,
                        color: R.colors.black,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "RS.",
                          style: R.textStyle.googleFontsPoppins(
                            size: 9.sp,
                            color: R.colors.black,
                            weight: FontWeight.w400,
                          ),
                        ),
                        w1,
                        Text(
                          data['price'],
                          style: R.textStyle.googleFontsPoppins(
                            size: 9.sp,
                            color: R.colors.black,
                            weight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PersistentShoppingCart().showAndUpdateCartItemWidget(
                  inCartWidget: Container(
                      height: 3.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: R.colors.lightGray,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Text(
                          'Remove',
                          style: R.textStyle.googleFontsPoppins(
                              size: 8.sp, color: R.colors.black),
                        ),
                      )),
                  notInCartWidget: Container(
                      height: 3.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: R.colors.lightGray,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Text(
                          'Add to Cart',
                          style: R.textStyle.googleFontsPoppins(
                              size: 8.sp, color: R.colors.black),
                        ),
                      )),
                  product: PersistentShoppingCartItem(
                      productId: data['id'],
                      productName: data['title'],
                      unitPrice: double.parse(data['price'].toString()),
                      quantity: 1))
            ],
          ),
        );
      },
    );
  }

  Widget userName(dynamic map) {
    return Text(
      map['userName'],
      style: R.textStyle.googleFontsPoppins(
          size: 20.sp,
          weight: FontWeight.bold,
          color: R.colors.primraryTextColor),
    );
  }

  Widget searchTextFormField() {
    return TextFormField(
      style: R.textStyle.googleFontsPoppins(
          weight: FontWeight.w400,
          size: 12.sp,
          decoration: TextDecoration.none,
          color: R.colors.primraryTextColor),
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: searchController,
      focusNode: searchNode,
      decoration: R.fieldDecoration.decoration(
        suffixIcon: InkWell(
          onTap: () {},
          child: Icon(
            Icons.search,
            color: R.colors.primraryTextColor,
          ),
        ),
        borderColor: R.colors.splashColor,
        textStyle: R.textStyle.googleFontsPoppins(
            weight: FontWeight.w400,
            size: 12.sp,
            decoration: TextDecoration.none,
            color: R.colors.primraryTextColor),
        hint: 'Search by price...',
        radius: 15,
        filled: true,
        fillcolor: R.colors.searchField,
      ),
    );
  }
}
