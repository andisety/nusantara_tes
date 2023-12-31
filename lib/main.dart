import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nusantara_tes/ui/authScreen.dart';
import 'package:nusantara_tes/ui/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = await checkLoginStatus();
  runApp(MyApp(isLoggedIn: isLoggedIn));

//   runApp(GetMaterialApp(

//     debugShowCheckedModeBanner: false,
//     home: isLoggedIn ? HomePage() : AuthScreen(),
//     // home: AuthScreen(),
//   ));
// }

// Future<bool> checkLoginStatus() async {
//   String? token = await SharedPreferences.getInstance()
//       .then((prefs) => prefs.getString('token'));
//   return token != null;
// }
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? HomePage() : AuthScreen(),
    );
  }
}

Future<bool> checkLoginStatus() async {
  String? token = await SharedPreferences.getInstance()
      .then((prefs) => prefs.getString('token'));
  return token != null;
}
