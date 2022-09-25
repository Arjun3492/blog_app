import 'package:blog_minimal/core/constants/firebase_constants.dart';
import 'package:blog_minimal/core/constants/firestore_constants.dart';
import 'package:blog_minimal/core/constants/localStorage.dart';
import 'package:blog_minimal/modules/auth/model/user_model.dart';
import 'package:blog_minimal/modules/auth/view/signin.dart';
import 'package:blog_minimal/modules/home/view/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

class AuthController extends GetxController {
  Rx<User?> _currentUser = Rx(auth.currentUser);
  onReady() {
    _currentUser.bindStream(auth.authStateChanges());
    ever(_currentUser, setInitialScreen);
  }

//Setting the initial screen of the project
  setInitialScreen(User? user) {
    try {
      if (user == null) {
        Get.offAll(SignIn());
      } else {
        Get.offAll(HomePage());
      }
    } catch (e) {
      print(e);
    }
  }

//Signing in the user
  Future<void> signInUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCred = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      Get.snackbar("Successfully logged in", "");
    } catch (e) {
      Get.snackbar(e.toString(), "");
    }
  }

//Registering user and setting the username
  Future<void> signUpUserWithEmailAndPassword(
      {required String username,
      required String email,
      required String password}) async {
    try {
      UserCredential userCred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await userCred.user?.updateDisplayName(username);
      final user = UserModel.fromMap({
        'username': username ?? "",
        'email': email ?? "",
        'uid': userCred.user?.uid ?? "",
      });
      await Firestore.setUserInfo(user.toMap(), user.uid!);
      await localStorage.write(key: "user", value: username);
      Get.snackbar("Successfully registered", "");
    } catch (e) {
      Get.snackbar(e.toString(), "");
    }
  }

//Signing out the user
  Future<void> signOut() async {
    try {
      await auth.signOut();
      Get.snackbar("Successfully logged Out", "");
    } catch (e) {
      Get.snackbar(e.toString(), "");
    }
  }
}
