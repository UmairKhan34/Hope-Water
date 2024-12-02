import 'package:get/get.dart';
import 'package:hopewater/src/auth/view/forgot_view.dart';
import 'package:hopewater/src/auth/view/login_view.dart';
import 'package:hopewater/src/auth/view/sign_up_view.dart';
import 'package:hopewater/src/base/view/base_view.dart';
import 'package:hopewater/src/base/view/favourite/view/favourite_view.dart';
import 'package:hopewater/src/base/view/favourite/view/order_placed.dart';
import 'package:hopewater/src/base/view/home/view/home_view.dart';
import 'package:hopewater/src/base/view/profile/view/feed_back_view.dart';
import 'package:hopewater/src/base/view/profile/view/profile_view.dart';
import 'package:hopewater/src/landing/finish_on_boarding.dart';
import 'package:hopewater/src/landing/on_boarding_one.dart';
import 'package:hopewater/src/landing/on_boarding_two.dart';
import 'package:hopewater/src/landing/splash_view.dart';
import 'package:hopewater/src/landing/welcome_screen.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(name: SplashView.route, page: () => const SplashView()),
    GetPage(name: LoginViewScreen.route, page: () => const LoginViewScreen()),
    GetPage(
        name: FinishOnBoardingScreen.route,
        page: () => const FinishOnBoardingScreen()),
    GetPage(
        name: OnBoardingOneView.route, page: () => const OnBoardingOneView()),
    GetPage(
        name: OnBoardingTwoView.route, page: () => const OnBoardingTwoView()),
    GetPage(name: WelcomeScreen.route, page: () => const WelcomeScreen()),
    GetPage(name: SignUpViewScreen.route, page: () => const SignUpViewScreen()),
    GetPage(name: HomeViewScreen.route, page: () => const HomeViewScreen()),
    GetPage(
        name: ProfileSettingView.route, page: () => const ProfileSettingView()),
    GetPage(
        name: FavouriteViewScreen.route,
        page: () => const FavouriteViewScreen()),
    GetPage(name: BaseView.route, page: () => const BaseView()),
    GetPage(name: ForgotViewScreen.route, page: () => const ForgotViewScreen()),
    GetPage(name: UserFeedBackView.route, page: () => const UserFeedBackView()),
    GetPage(name: OrderPlaced.route, page: () => const OrderPlaced()),
  ];
}
