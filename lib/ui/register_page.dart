import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nusantara_tes/controllers/registerController.dart';

import '../utils/utils.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController registerController = Get.put(RegisterController());

  Future<void> _register() async {
    if (registerController.nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Nama tidak boleh kosong"),
      ));
    } else if (registerController.emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Email tidak boleh kosong"),
      ));
    } else if (registerController.pwdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password tidak boleh kosong"),
      ));
    } else if (registerController.pwd2Controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password Konfirmasi tidak boleh kosong"),
      ));
    } else {
      try {
        registerController.register();
        registerController.isLoading(false);
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
              Image.asset(image2),
              Text(
                "Please Register",
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
                controller: registerController.nameController,
                style: const TextStyle(color: kInputColor),
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Name",
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
                height: size.height * 0.024,
              ),
              TextField(
                controller: registerController.emailController,
                style: const TextStyle(color: kInputColor),
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Email",
                  prefixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.email_rounded,
                        color: kInputColor,
                      )),
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
                controller: registerController.pwdController,
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
                height: size.height * 0.020,
              ),
              TextField(
                controller: registerController.pwd2Controller,
                obscureText: true,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: kInputColor),
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Password Confirmation",
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
                    return registerController.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(KWhiteColor),
                          )
                        : const Text(
                            "Register",
                            style: TextStyle(
                              color: KWhiteColor,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                  }),
                ),
                onPressed: () {
                  _register();
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
                  Get.back();
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
                    "Log In",
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
