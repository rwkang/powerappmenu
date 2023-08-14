import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:powerappmenu/controller/PostController.dart';
import 'package:powerappmenu/view/pages/post/UpdatePage.dart';

import '../../../controller/UserController.dart';
import 'HomePage.dart';

class DetailPage extends StatelessWidget {
  // const DetailPage({super.key});

  // final int id; // 반드시 "required" 필수.
  final int? id;

  DetailPage({super.key, this.id}); // "final int? id" 이렇게 정의하거나, "required"로 생성해야 된다.
  // const DetailPage({super.key, required this.id}); // "final int? id" 이렇게 정의하거나, "required"로 생성해야 된다.
  // const DetailPage({required this.id});

  // const DetailPage({super.key, required this.id, required String arguments});
  // const DetailPage({this.id}); // 이렇게 에러 나네... "final int? id" 이렇게 정의해야 된다.

  /// 2023.08.10 Added. DB 자료를 가져온 후.
  UserController userController = Get.find(); /// 로그인 상태: isLogin
  PostController postController = Get.find();


  @override
  Widget build(BuildContext context) {
    // String data = Get.arguments;

    /// 2023.08.13 Conclusion. 로그인된 User 정보를 가져올 수 있다.
    print("Details.java/userController.principal.value.id: ${userController.principal.value.id}");
    print("Details.java/userController.principal.value.id: ${userController.principal.value.username}");
    print("===============================================");

    return Scaffold(
      appBar: AppBar(
        title: Text("게시글 ID: ${id}, 로그인 상태: ${userController.isLogin}"),
      ),
      // body: Center(
      //   child: Text("Detail Page $id"),
      //   // child: Text("Detail Page $id $data"),
      //   // child: Text("Detail Page " + id.toString() + data),
      // ),

      /// 2023.08.10 Added. HomePage()에서, 특정 게시글을 "클릭"할 때, findByIdPostController(id)를 실행하게 한다.
      /// 그러면, PostController.java 파일에서, "this.post.value"에, 특정 게시글 자료가 담길 것이므로,
      /// DetailPage.java 파일에서는, 뿌려지는 "Column" 위젯을, Obx(() => Column()) 이런식으로 감싸 주기만 하면 된다.

      body: Obx(()=> Column(
        children: [
          // Text("글 제목", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          Text("${postController.post.value.title}", style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          /// * 주의 : postContorller.post.title ===> postController.post.value.title 즉 vlaue 있음에 주의 *

          Divider(),

          /// 2023.08.13 Conclusion. 로그인 된 User 정보를 가져와서, Post.user 정보와 비교, "내 게시물"일 때,
          /// "수정", "삭제" 버튼이 보이게 한다.
          // Row(
          userController.principal.value.id == postController.post.value.user!.id ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () async {

                  /// 2023.08.13 Added. Post.1개 자료만 삭제.
                  await postController.deleteByIdPostController(postController.post.value.id!); /// 절대 null 값이 올 수 없다.
                  // await postController.deleteByIdPostController(postController.post.value.id ?? 0); /// 혹시 null 값이 올 수도 있다면, 이런식으로 처리.

                  // 2023.08.06 Conclusion. 뒤로 가기 ← 아이콘 정리.
                  // => UpdatePage() 설명 참조할 것

                  Get.off(() => HomePage()); // 상태 관리로 "갱신"시킬 수 있다, 단, "Stack" 메모리에서 완전히 삭제시켜 버린다.
                  // Get.back(); // *** 특히 주의: 뒤로 가기로 하면, 삭제되 내용이 "갱신"이 안 되어 있기 때문이다. 갱신은 되는데, 위험하다.
                  // Get.to(HomePage()); // 상태 관리로 "갱신"시킬 수 있다. 단, "Stack" 메모리에 남겨 놓는다.

                },
                child: const Text("삭제"),
              ),
              ElevatedButton(
                onPressed: () {

                  /// 2023.08.14 Conclustion. 수정 버튼 클릭 시, 현재 정보를 넘기는 2가지 방법이 있다.
                  /// 1. arguments로 넘기는 방법: Get.to(() => UpdatePage(), arguments: ~~)
                  /// 2. 생성자에 가져가는 방법: Post 전체 자료를 가져가도 되는데,

                  // Get.off(UpdatePage(id: id));
                  // Get.off(UpdatePage());
                  // Get.to(() => UpdatePage(), arguments: );
                  Get.to(() => UpdatePage());
                },
                child: const Text("수정"),
              ),
            ],
          ) : const SizedBox(),
          // ),


          // Expanded(child: SingleChildScrollView(child: Text("글 내용!!" * 500))),
          Expanded(child: SingleChildScrollView(child: Text("${postController.post.value.content}"),),),
          /// * 주의 : postContorller.post.title ===> postController.post.value.title 즉 vlaue 있음에 주의 *

          // 이렇게 "글 내용"이 너무 크면, 화면이 깨진다. ∴) 반드시 먼저 "SingleChildScrollView" 위젯으로 감싸고, 그것을 다시 "Expanded"로 깜싸 주어야 한다.
        ],
      ),),
    );
  }
}
