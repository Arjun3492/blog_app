import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();

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
}
