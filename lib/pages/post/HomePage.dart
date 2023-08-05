import 'package:flutter/material.dart';
import 'package:powerappmenu/size.dart';

import '../../components/left_menu.dart';

class HomePage extends StatelessWidget {
  // const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar()는 자동으로 "뒤로 가기.←" 아이콘이 생성되는데,
      // 그것을 못 뜨게 "Container" 위젯으로 Left Menu.왼쪽 메뉴 컨테이너를 둔다.
      drawer: LeftMenu(),
      appBar: AppBar(),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}

