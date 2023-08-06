import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../user/UpdatePage.dart';
import 'HomePage.dart';

class DetailPage extends StatelessWidget {
  // const DetailPage({super.key});

  // final int id; // 반드시 "required" 필수.
  final int? id;

  const DetailPage({super.key, this.id}); // "final int? id" 이렇게 정의하거나, "required"로 생성해야 된다.
  // const DetailPage({super.key, required this.id}); // "final int? id" 이렇게 정의하거나, "required"로 생성해야 된다.
  // const DetailPage({required this.id});

  // const DetailPage({super.key, required this.id, required String arguments});
  // const DetailPage({this.id}); // 이렇게 에러 나네... "final int? id" 이렇게 정의해야 된다.

  @override
  Widget build(BuildContext context) {
    // String data = Get.arguments;

    return Scaffold(
      appBar: AppBar(),
      // body: Center(
      //   child: Text("Detail Page $id"),
      //   // child: Text("Detail Page $id $data"),
      //   // child: Text("Detail Page " + id.toString() + data),
      // ),

      body: Column(
        children: [
          Text("글 제목", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

          Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {

                  // 2023.08.06 Conclusion. 뒤로 가기 ← 아이콘 정리.
                  // => UpdatePage() 설명 참조할 것

                  Get.off(HomePage()); // 상태 관리로 "갱신"시킬 수 있다, 단, "Stack" 메모리에서 완전히 삭제시켜 버린다.
                  // Get.to(HomePage()); // 상태 관리로 "갱신"시킬 수 있다. 단, "Stack" 메모리에 남겨 놓는다.
                  // Get.back(); // *** 특히 주의: 뒤로 가기로 하면, 삭제되 내용이 "갱신"이 안 되어 있기 때문이다.

                },
                child: Text("삭제"),
              ),
              ElevatedButton(
                onPressed: () {
                  // Get.off(UpdatePage(id: id));
                  // Get.off(UpdatePage());
                  Get.to(UpdatePage());
                },
                child: Text("수정"),
              ),
            ],
          ),


          Expanded(child: SingleChildScrollView(child: Text("글 내용!!" * 500))),
          // 이렇게 "글 내용"이 너무 크면, 화면이 깨진다. ∴) 반드시 먼저 "SingleChildScrollView" 위젯으로 감싸고, 그것을 다시 "Expanded"로 깜싸 주어야 한다.
        ],
      ),
    );
  }
}
