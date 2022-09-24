import 'package:blog_minimal/core/constants/firebase_constants.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  static Reference getPostImageRef() {
    return storage.ref("Posts/");
  }
}
