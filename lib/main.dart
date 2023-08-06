import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:powerappmenu/pages/post/HomePage.dart';
import 'package:powerappmenu/pages/user/JoinPage.dart';
import 'package:powerappmenu/pages/user/LoginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  //   return const Placeholder(
    // GetX 라이브러리 Dependency Injection 후, GetMaterialApp 위젯으로 변경한다.
    // return MaterialApp(
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,

      // 라우터 설계 필요 없음. GetX 사용할 예정

      home: HomePage(),
      // home: JoinPage(),
      // home: LoginPage(),

    );
  }
}
