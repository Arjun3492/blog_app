import 'package:blog_minimal/core/constants/firebase_constants.dart';
import 'package:blog_minimal/modules/auth/view/signin.dart';
import 'package:blog_minimal/modules/home/view/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Rx<User?> _currentUser = Rx(auth.currentUser);
  User? get currentUser => _currentUser.value;
  onInit() {}
  onReady() {
    _currentUser.bindStream(auth.userChanges());
    ever(_currentUser, setInitialScreen);
  }

// setting the initial screen of the project
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

//signing in the user and setting the username
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

//Registering user
  Future<void> signUpUserWithEmailAndPassword(
      String username, String email, String password) async {
    try {
      UserCredential userCred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await userCred.user?.updateDisplayName(username);
      Get.snackbar("Successfully registered", "");
    } catch (e) {
      Get.snackbar(e.toString(), "");
    }
  }

//signing out the user
  Future<void> signOut() async {
    try {
      await auth.signOut();
      Get.snackbar("Successfully logged Out", "");
    } catch (e) {
      Get.snackbar(e.toString(), "");
    }
  }

  onClose() {}
}
