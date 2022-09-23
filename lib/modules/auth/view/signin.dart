import 'package:blog_minimal/core/constants/validators.dart';
import 'package:blog_minimal/modules/auth/controller/sign_in_controller.dart';
import 'package:blog_minimal/modules/home/view/home_page.dart';
import 'package:blog_minimal/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Get.put(SignInController());
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Sign In',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: SingleChildScrollView(
            child: Form(
              key: controller.signInKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: width,
                      child: Image.asset(
                        'assets/images/logo-png.png',
                        width: width * 0.5,
                        height: height * 0.3,
                      )),
                  Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: height * 0.01),
                  CustomTextField(
                    hint: 'Enter Email',
                    validator: validateEmail,
                    controller: controller.emailController,
                  ),
                  SizedBox(height: height * 0.03),
                  Text('Password',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: height * 0.01),
                  CustomTextField(
                      hint: 'Enter Password',
                      validator: validatePassword,
                      controller: controller.passwordController),
                  SizedBox(height: height * 0.05),
                  Center(
                    child: Container(
                        width: width * 0.5,
                        height: height * 0.06,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff11586b))),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage())),
                            child: Obx(() => controller.loading.value
                                ? CircularProgressIndicator()
                                : Text("Sign-In")))),
                  ),
                  SizedBox(height: height * 0.05),
                  GestureDetector(
                    child: Text("GO TO SIGNUP"),
                    onTap: () => controller.onClickSignUp(),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
