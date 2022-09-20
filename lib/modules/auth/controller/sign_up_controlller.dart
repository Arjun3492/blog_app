import 'package:blog_minimal/modules/auth/controller/auth_controller.dart';
import 'package:blog_minimal/modules/auth/view/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final AuthController authController = Get.put(AuthController());
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final signUpkey = GlobalKey<FormState>();
  bool loading = false;

  toggleLoading() {
    loading = !loading;
    update();
  }

//signing up the user
  onClickSignUp() async {
    if (signUpkey.currentState!.validate()) {
      try {
        toggleLoading();
        await authController.signUpUserWithEmailAndPassword(
            usernameController.text.trim(),
            emailController.text.trim(),
            passwordController.text.trim());
        Get.offAll(SignIn());
      } finally {
        toggleLoading();
      }
    }
  }
}
