import 'package:blog_minimal/core/constants/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  static DocumentReference<Map<String, dynamic>> userDocRef(String uid) {
    return db.collection('users').doc(uid);
  }

  static Future<void> setUserInfo(Map<String, dynamic> data, String uid) async {
    await userDocRef(uid).set(data);
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(
      String uid) async {
    return await userDocRef(uid).get();
  }
}
