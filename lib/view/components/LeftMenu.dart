import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:powerappmenu/controller/PostController.dart';
import 'package:powerappmenu/util/Jwt.dart';
import 'package:powerappmenu/view/pages/post/HomePage.dart';

import '../../controller/UserController.dart';
import '../../size.dart';
import '../pages/post/WritePage.dart';
import '../pages/user/LoginPage.dart';
import '../pages/user/UserInfo.dart';

class LeftMenu extends StatelessWidget {
  // const LeftMenu({super.key});

  /// 2023.08.08 Added. Login.로그인 페이지로 가기 전에,
  /// 반드시, 아래 내용을 먼저 초기화 해 주어야 한다.
  /// 1> 상태 관리 초기화: isLogin.value = false;
  /// 2> 토큰 초기화: jwtToken = null;

  /// 이를 위하여, 상단에 UserController userController = Get.find(); 선언을 해 주어야 한다.
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      /// drawer: "서랍장"
      /// width: 250, // 폰 마다 Size가 다르므로, 이렇게 상수를 주면 위험(Overflow Error)하다. 메인 폴더에 "size.dart" 파일을 만들어서 관리한다.
      /// width: getScreenWidth(context) * .6, // 이것도 따로 빼서, 다른 곳에서 사용할 수 있도록 한다.
      width: getDrawerWidth(context),
      height: double.infinity,
      color: Colors.white,

      // Left Menu 구성

      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column( // 너무 화면 위에 붙어 있어, "SafeArea" 위젯으로 감싸 주고, "Padding"도 적당히 16.0 준다.
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start, // "Column"은 메인이 "CrossAxiasAlignment"
            children: [
              TextButton(
                onPressed: () {

                  Get.to(() => WritePage());

                },
                child: const Text(
                  "글 쓰기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              const Divider(), // 구분 선
              TextButton(
                onPressed: () {

                  /// 2023.08.14 Added. UserInfo.회원 정보 보기 화면으로 가서, 다시 뒤로 가기 아이콘(←)을 클릭했을 때,
                  /// LeftMenu() 화면으로 갈 것이 아니라, 바로 HomePage.홈 화면으로 가야된다.
                  /// 그러기 위해서는, "Stack" 메모리에서 가장 최상단에 올라와 있는 것(지금은 LeftMenu())을 .pop(제거)해 주면 된다.

                  Navigator.pop(context);

                  Get.to(() => UserInfo());
                },
                child: const Text(
                  "회원 정보 보기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              const Divider(), // 구분 선
              TextButton(
                onPressed: () {

                  // 2023.08.08 Added. Login.로그인 페이지로 가기 전에,
                  // 반드시, 아래 내용을 먼저 초기화 해 주어야 한다.
                  // 1> 상태 관리 초기화: isLogin.value = false;
                  // 2> 토큰 초기화: jwtToken = null;
                  // 이를 위하여, 상단에 UserController userController = Get.find(); 선언을 해 주어야 한다.
                  // userController.isLogin.value = false;
                  // jwtToken = null;
                  // ===> 그런데,
                  // 여기서 이렇게 자질구레하게 처리하는 것 보다,
                  // UserController.dart 파일에서, 펑션 처리하고, 여기서는 그 펑션만 호출하는 것이 매우 깔끔하다 할 수 있겠다.

                  userController.logout();

                  Get.to(LoginPage());
                  // Get.to(LogoutPage());
                },
                child: const Text(
                  "로그아웃",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              const Divider(), // 구분 선
            ],
          ),
        ),
      ),
    );
  }
}
