import 'package:blog_minimal/modules/home/controller/home_controller.dart';
import 'package:blog_minimal/modules/post/view/create_post.dart';
import 'package:blog_minimal/widgets/post_cell_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Revamph Prompt',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          InkWell(
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Icon(
                      Icons.notifications_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 0,
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFFFD810),
        elevation: 0,
        onPressed: () => Get.to(CreatePost()),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for articles, author, and tags',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<HomeController>(
                builder: ((controller) => (controller.loading)
                    ? //code1
                    Center(child: CircularProgressIndicator())
                    : //code2
                    (controller.posts.isEmpty)
                        ? //code2-1
                        Center(child: Text("No Posts"))
                        : //code2-2
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your feed',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller.posts.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final post = controller.posts[index];
                                    return Card(
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: PostCellWidget(
                                            title: post.title ?? "",
                                            image: post.imageUrl ?? "",
                                            author: post.createdBy ?? "",
                                            date: "",
                                            onClick: () => null),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      Divider(),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
