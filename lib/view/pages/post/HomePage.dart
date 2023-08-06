import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:powerappmenu/size.dart';

import '../../components/LeftMenu.dart';
import 'DetailPage.dart';

class HomePage extends StatelessWidget {
  // const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar()는 자동으로 "뒤로 가기.←" 아이콘이 생성되는데,
      // 그것을 못 뜨게 "Container" 위젯으로 Left Menu.왼쪽 메뉴 컨테이너를 둔다.
      drawer: LeftMenu(),
      appBar: AppBar(),
      body: ListView.separated(
        // "구분 선"을 줄 때는, "builder" 보다 "separated"가 좋다.
        itemCount: 30, // 3번 만큼, 아래 "ListTile()" 위젯이 뿌려진다. 수량이 많아지면, 자동으로 "스크롤"이 생긴다.
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () { // 상세 페이지로 이동.
              // 11강: GetX에서는,
              // 1> "Constructor.생성자"로 넘기는 방법이 있고,
              // 2> "arguments"를 통해서, 값을 넘길 수 있는, 2가지 방법이 있다.
              // 그런데, 2023.08.06 현재, "arguments" 방식은 안 되네...
              // Get.to(DetailPage(id: index, arguments: "arguments 방식도 있는데?"));
              Get.to(DetailPage(id: index));
            },
            title: Text("제목1"),
            leading: Text("1"),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
