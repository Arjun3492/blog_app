import 'package:blog_minimal/core/constants/firestore_constants.dart';
import 'package:blog_minimal/modules/post/model/post_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  bool loading = false;
  List<PostModel> posts = [];

  // change the loading state
  toggleLoading() {
    loading = !loading;
    update();
  }

  fetchPosts() async {
    try {
      toggleLoading();
      posts = await Firestore.getAllPosts();
    } catch (e) {
      Get.snackbar(e.toString(), "");
    } finally {
      toggleLoading();
    }
  }

  @override
  void onInit() {
    fetchPosts();
    // TODO: implement onInit
    super.onInit();
  }
}



// FutureBuilder<List<PostModel>>(future:controller.fetchPosts(),
// builder: (context, snapshot) {
//   if(snapshot.hasdata()) {
//     if(snapshot.data.isEmpty){
//       return Text("no post")
//     }else{
//       //actual data
//     }
//   }
// }