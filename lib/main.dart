import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kbcquiz/LocalDB/localDB.dart';
import 'package:kbcquiz/Localizations/localizationService.dart';
import 'package:kbcquiz/Themes/themes.dart';

import 'Routes/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  RxBool isLoagin = false.obs;
  getLoggedIn() async {
    await LocalDB.getUserID().then((value) {
      isLoagin.value = value.toString() != "Null";
    });
  }

  @override
  Widget build(BuildContext context) {
    getLoggedIn();
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: isLoagin.value ? Routes.signInView : Routes.homeView,
      getPages: Pages.routses,
      debugShowCheckedModeBanner: false,
      theme: Themes.lighTheme,
      darkTheme: Themes.darkTheme,
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
    );
  }
}
