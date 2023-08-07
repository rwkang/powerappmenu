import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/UserController.dart';
import '../../components/LeftMenu.dart';
import 'DetailPage.dart';

class HomePage extends StatelessWidget {
  // const HomePage({super.key});

  // 20230.08.08 Added. /controller/UserController.dart/RxBool isLogin 상태 관리 확인을 위한 임시...
  // 30강서는, 여기 "Widget" 안에서도 선언 가능하다고 했는데, 현재는 여기서는 안 되고, 반드시 상단, "class" 안에 넣어야 하네...

  // Get.put() : 없으면 새로 만들고, 있으면 찾아라는 것이므로, 여기서는 .find()를 사용한다.
  // UserController userController = Get.put(UserController());
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // 20230.08.08 Added. /controller/UserController.dart/RxBool isLogin 상태 관리 확인을 위한 임시...
      // 30강서는, 여기 "Widget" 안에서도 선언 가능하다고 했는데, 현재는 여기서는 안 되고, 반드시 상단, "class" 안에 넣어야 하네...

      // Get.put() : 없으면 새로 만들고, 있으면 찾아라는 것이므로, 여기서는 .find()를 사용한다.
      // UserController userController = Get.put(UserController());
      // UserController userController = Get.find();

      // AppBar()는 자동으로 "뒤로 가기.←" 아이콘이 생성되는데,
      // 그것을 못 뜨게 "Container" 위젯으로 Left Menu.왼쪽 메뉴 컨테이너를 둔다.
      drawer: LeftMenu(),
      appBar: AppBar(

        // 20230.08.08 Added. /controller/UserController.dart/RxBool isLogin 상태 관리 확인을 위한 임시...
        // title: Text("로그인 상태 ===> ${userController.isLogin.value}"), // ===> 아래 참조.
        // 그럼 어떻게 처리해야 UI가 상태를 변경할 수 있을까? 그것은 간단하게도, 
        // 상기 [userController.isLogin.value] 변수를, "Obx()" 펑션 안에 넣어 주기만 하면 된다.
        title: Obx(() => Text("로그인 상태 ===> ${userController.isLogin.value}")),
        
        // 2023.08.08 Added. 예를 들어, /controller/UserController.dart 파일에, isLogin 변수 값을 "false"로 강제 변경하는 메소드를 만들고,
        // 아래 "+" 아이콘을 클리하면, 해당 forceChangeFalseInIsLogin() 메소드를 실행하게 해 본다.
        // ***** 이미 "true"로 찍혀 있는 상태에서는 변경되지 않는다 *****
        // 그럼 어떻게 처리해야 UI가 상태를 변경할 수 있을까? 그것은 간단하게도,
        // 상기 [userController.isLogin.value] 변수를, "Obx()" 펑션 안에 넣어 주기만 하면 된다.
        actions: [IconButton(onPressed: () {
          userController.forceChangeFalseInIsLogin();
        }, icon: Icon(Icons.add))],


      ),
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
