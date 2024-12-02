import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hopewater/routes/routes_view.dart';
import 'package:hopewater/src/auth/view_model/auth_vm.dart';
import 'package:hopewater/src/base/view/profile/view_model/profile_vm.dart';
import 'package:hopewater/src/base/view_model/base_vm.dart';
import 'package:hopewater/src/landing/splash_view.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

void main() async {
  await PersistentShoppingCart().init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthVM()),
        ChangeNotifierProvider(create: (_) => ProfileVM()),
        ChangeNotifierProvider(create: (_) => BaseVM())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hope Water',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashView(),
        initialRoute: SplashView.route,
        getPages: AppRoutes.pages,
      );
    });
  }
}
