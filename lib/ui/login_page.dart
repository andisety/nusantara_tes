import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nusantara_tes/ui/register_page.dart';

import '../controllers/loginController.dart';
import '../utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = Get.put(LoginController());

  Future<void> _login() async {
    if (loginController.emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Email tidak boleh kosong"),
      ));
    } else if (loginController.pwdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password tidak boleh kosong"),
      ));
    } else {
      try {
        loginController.login();
        loginController.isLoading(false);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [g1, g2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(size.height * 0.030),
          child: Column(
            children: [
              Image.asset(image1),
              Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: KWhiteColor.withOpacity(0.7),
                ),
              ),
              Text(
                "Please Log In",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: KWhiteColor.withOpacity(0.7),
                ),
              ),
              SizedBox(
                height: size.height * 0.024,
              ),
              TextField(
                controller: loginController.emailController,
                style: const TextStyle(color: kInputColor),
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Email",
                  prefixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.person_2_rounded)),
                  fillColor: KWhiteColor,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(37)),
                ),
              ),
              SizedBox(
                height: size.height * 0.020,
              ),
              TextField(
                controller: loginController.pwdController,
                obscureText: true,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: kInputColor),
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Password",
                  prefixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.vpn_key_rounded)),
                  fillColor: KWhiteColor,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(37)),
                ),
              ),
              SizedBox(
                height: size.height * 0.030,
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  height: size.height * 0.080,
                  decoration: BoxDecoration(
                    color: KButtonColor,
                    borderRadius: BorderRadius.circular(37),
                  ),
                  child: Obx(() {
                    return loginController.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(KWhiteColor),
                          )
                        : const Text(
                            "Log In",
                            style: TextStyle(
                              color: KWhiteColor,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                  }),
                ),
                onPressed: () {
                  _login();
                },
              ),
              SizedBox(
                height: size.height * 0.040,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 150,
                    height: 1,
                    color: Colors.white54,
                  ),
                  const Text(
                    "OR",
                    style: TextStyle(
                        color: KWhiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Container(
                    width: 150,
                    height: 1,
                    color: Colors.white54,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.040,
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                borderRadius: BorderRadius.circular(37),
                color: Color.fromRGBO(225, 225, 225, 0.25),
                onPressed: () {
                  Get.to(() => RegisterPage());
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  height: size.height * 0.080,
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      blurRadius: 45,
                      spreadRadius: 0,
                      color: Color.fromRGBO(120, 37, 138, 0.25),
                    )
                  ]),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: KWhiteColor, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
