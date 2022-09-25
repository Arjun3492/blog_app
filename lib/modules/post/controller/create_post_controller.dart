import 'package:blog_minimal/core/constants/firestorage_constants.dart';
import 'package:blog_minimal/core/constants/firestore_constants.dart';
import 'package:blog_minimal/core/constants/localStorage.dart';
import 'package:blog_minimal/modules/home/controller/home_controller.dart';
import 'package:blog_minimal/modules/home/view/home_page.dart';
import 'package:blog_minimal/modules/post/model/post_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final HomeController homeController = Get.find();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  Rx<bool> loading = Rx(false);
  Rx<bool> imageLoading = Rx<bool>(false);
  Rx<Uint8List?> _imageBytes = Rx(null);
  Uint8List? get imageBytes => _imageBytes.value;

  pickImage() async {
    try {
      ImagePicker _imagePicker = ImagePicker();
      imageLoading.value = true;
      XFile? xfile = await _imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      if (xfile != null) {
        _imageBytes.value = await xfile.readAsBytes();
      } else {
        _imageBytes.value = null;
      }
    } finally {
      imageLoading.value = false;
    }
  }

  savePost() async {
    if (formKey.currentState!.validate()) {
      if (imageBytes != null) {
        try {
          loading.value = true;
          String? id = DateTime.now().millisecondsSinceEpoch.toString();
          String? imageUrl = await uploadImage(id);
          String username = (await localStorage.read(key: "user")) ?? "";
          PostModel postModel = PostModel.fromMap({
            "title": titleController.text,
            "desc": descController.text,
            "id": id,
            "imageUrl": imageUrl,
            "createdBy": username,
          });

          await Firestore.setPostInfo(postModel.toMap(), id);
          Get.back();
          Get.snackbar("Post saved successfully", "");
          await homeController.fetchPosts();
        } catch (e) {
          Get.snackbar('Error', e.toString());
        } finally {
          loading.value = false;
        }
      } else {
        Get.snackbar("Please select an image", "");
      }
    }
  }

  Future<String?> uploadImage(String id) async {
    try {
      Reference fileRef = FireStorage.getPostImageRef().child("$id.jpg");
      await fileRef.putData(imageBytes!);
      String imageUrl = await fileRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
