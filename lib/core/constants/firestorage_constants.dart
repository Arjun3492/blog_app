import 'package:blog_minimal/core/constants/firebase_constants.dart';

class FireStorage {
  static getPostImageRef() {
    return storage.ref("Posts/");
  }
}
