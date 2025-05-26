import 'package:book_buddy/GetX%20MVVM/data/network/network_controller.dart';
import 'package:book_buddy/GetX%20MVVM/resources/getx_localization/languages.dart';
import 'package:book_buddy/GetX%20MVVM/resources/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NetworkController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        primaryColor: const Color(0xFF1A2980),
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A2980),
          foregroundColor: Colors.white,
        ),
      ),
      translations: Languages(),
      locale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      getPages: Routes.appRoutes(),
    );
  }
}
