import 'package:blog_minimal/core/constants/validators.dart';
import 'package:blog_minimal/modules/auth/controller/sign_up_controlller.dart';
import 'package:blog_minimal/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final controller = Get.put(SignUpController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Sign Up',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: SingleChildScrollView(
            child: Form(
              key: controller.signUpkey,
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
                  Text('UserName',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: height * 0.01),
                  CustomTextField(
                      hint: 'Enter UserName',
                      controller: controller.usernameController,
                      validator: validateName),
                  SizedBox(height: height * 0.03),
                  Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: height * 0.01),
                  CustomTextField(
                      hint: 'Enter Email',
                      controller: controller.emailController,
                      validator: validateEmail),
                  SizedBox(height: height * 0.03),
                  Text('Password',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: height * 0.01),
                  CustomTextField(
                      hint: 'Enter Password',
                      controller: controller.passwordController,
                      validator: validatePassword),
                  SizedBox(height: height * 0.05),
                  Center(
                    child: Container(
                        width: width * 0.5,
                        height: height * 0.06,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff11586b))),
                            onPressed: () => controller.onClickSignUp(),
                            child: GetBuilder<SignUpController>(
                                init: controller,
                                builder: (controller) => controller.loading
                                    ? CircularProgressIndicator()
                                    : Text("Sign-Up")))),
                  ),
                  SizedBox(height: height * 0.05),
                  GestureDetector(
                    child: Text("GO TO SIGNIN"),
                    onTap: () => controller.onClickSignIn(),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
