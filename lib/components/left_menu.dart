import 'package:flutter/material.dart';

import '../size.dart';

class LeftMenu extends StatelessWidget {
  const LeftMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // drawer: "서랍장"
      // width: 250, // 폰 마다 Size가 다르므로, 이렇게 상수를 주면 위험하다. 메인 폴더에 "size.dart" 파일을 만들어서 관리한다.
      // width: getScreenWidth(context) * .6, // 이것도 따로 빼서, 다른 곳에서 사용할 수 있도록 한다.
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
                  onPressed: () {},
                  child: const Text(
                    "회원 정보 보기",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Divider(), // 구분 선
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "로그아웃",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Divider(), // 구분 선
              ],
            ),
          ),
        ));
  }
}
