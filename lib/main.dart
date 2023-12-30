import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nusantara_tes/ui/authScreen.dart';
import 'package:nusantara_tes/ui/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  bool isLoggedIn = await checkLoginStatus();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: isLoggedIn ? HomePage() : AuthScreen(),
    // home: AuthScreen(),
  ));
}

Future<bool> checkLoginStatus() async {
  String? token = await SharedPreferences.getInstance()
      .then((prefs) => prefs.getString('token'));
  return token != null;
}
