import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hopewater/resources/resources.dart';
import 'package:hopewater/src/base/view/favourite/view/order_placed.dart';
import 'package:hopewater/utilis/global_button.dart';
import 'package:hopewater/utilis/heights_width.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:sizer/sizer.dart';

class FavouriteViewScreen extends StatefulWidget {
  static String route = "/favouriteView";
  const FavouriteViewScreen({super.key});

  @override
  State<FavouriteViewScreen> createState() => _FavouriteViewScreenState();
}

class _FavouriteViewScreenState extends State<FavouriteViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0.w),
        child: Column(
          children: [
            h10,
            Expanded(
              child: PersistentShoppingCart().showCartItems(
                  cartTileWidget: ({required data}) => Card(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                h3,
                                Row(
                                  children: [
                                    Text(
                                      data.productName,
                                      style: R.textStyle.googleFontsPoppins(
                                          size: 17.sp, color: R.colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'RS.',
                                      style: R.textStyle.googleFontsPoppins(
                                          size: 10.sp, color: R.colors.black),
                                    ),
                                    w2,
                                    Text(
                                      data.unitPrice.toString(),
                                      style: R.textStyle.googleFontsPoppins(
                                          size: 10.sp, color: R.colors.black),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          PersistentShoppingCart()
                                              .removeFromCart(data.productId);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: R.colors.black,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      PersistentShoppingCart()
                                          .incrementCartItemQuantity(
                                              data.productId);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: R.colors.black,
                                    )),
                                Text(data.quantity.toString()),
                                IconButton(
                                    onPressed: () {
                                      PersistentShoppingCart()
                                          .decrementCartItemQuantity(
                                              data.productId);
                                    },
                                    icon: Icon(
                                      Icons.minimize,
                                      color: R.colors.black,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      )),
                  showEmptyCartMsgWidget: Center(
                    child: Text(
                      'Cart is empty',
                      style: R.textStyle.googleFontsPoppins(
                          color: R.colors.black, size: 20.sp),
                    ),
                  )),
            ),
            PersistentShoppingCart().showTotalAmountWidget(
                cartTotalAmountWidgetBuilder: (totalAmount) {
              return Visibility(
                visible: totalAmount == 0.0 ? false : true,
                child: Container(
                  decoration: BoxDecoration(
                      color: R.colors.lightGray,
                      borderRadius: BorderRadius.circular(12)),
                  width: double.infinity,
                  height: 10.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: R.textStyle.googleFontsPoppins(
                              size: 10.sp, color: R.colors.black),
                        ),
                        Text(
                          totalAmount.toString(),
                          style: R.textStyle.googleFontsPoppins(
                              size: 10.sp, color: R.colors.black),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
            h3,
            Visibility(
              child: GlobalButton(
                  height: 7.h,
                  title: 'Place Order',
                  color: R.colors.splashColor,
                  onpress: () {
                    PersistentShoppingCart().clearCart();
                    Get.toNamed(OrderPlaced.route);
                  }),
            ),
            h2,
          ],
        ),
      ),
    );
  }
}
