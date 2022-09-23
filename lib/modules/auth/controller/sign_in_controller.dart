import 'package:blog_minimal/modules/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blog_minimal/modules/auth/view/signup.dart';

class SignInController extends GetxController {
  final authController = Get.find<AuthController>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final signInKey = GlobalKey<FormState>();
  Rx<bool> loading = false.obs;

  toggleLoading() {
    loading.value = !loading.value;
  }

  onClickSignIn() async {
    if (signInKey.currentState!.validate()) {
      try {
        toggleLoading();
        await authController.signInUserWithEmailAndPassword(
            emailController.text.trim(), passwordController.text.trim());
      } finally {
        toggleLoading();
      }
    }
  }

  //goto SignIn
  onClickSignUp() {
    Get.offAll(SignUp());
  }
}
