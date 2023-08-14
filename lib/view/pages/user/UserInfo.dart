import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/UserController.dart';

class UserInfo extends StatelessWidget {
  // const UserInfo({super.key});

  /// 2023.08.14 Conclusion. HomePage()/LeftMenu.dart/UserInfo()에서, 굳이 User 정보를 보내고 여기서 받고 할 필요가 없다.
  /// ∵) 여기서 바로 찾으면(Get.find()) 되기 때문이다.

  UserController userController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("회원 번호: ${userController.principal.value.id}"),
            Text("회원 닉네임: ${userController.principal.value.username}"),
            Text("회원 이메일: ${userController.principal.value.email}"),
            Text("회원 가입 일자: ${userController.principal.value.created}"),
          ],
        ),
        // child: Text('회원 정보 보기'),
      ),
    );
  }
}
