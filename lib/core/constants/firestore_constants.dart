import 'package:blog_minimal/core/constants/firebase_constants.dart';
import 'package:blog_minimal/modules/post/model/post_model.dart';
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

  static DocumentReference<Map<String, dynamic>> postDocRef(String id) {
    return db.collection("posts").doc(id);
  }

  static Future<void> setPostInfo(Map<String, dynamic> data, String id) async {
    await postDocRef(id).set(data);
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getPosts() async {
    return (await db.collection("posts").get());
  }

  static Future<List<PostModel>> getAllPosts() async {
    List<PostModel> _posts = [];
    final postQuerySnap = await getPosts();
    for (var postDoc in postQuerySnap.docs) {
      _posts.add(PostModel.fromMap(postDoc.data()));
    }
    return _posts;
  }
}
