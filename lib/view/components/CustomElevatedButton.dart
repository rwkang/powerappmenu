import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  // const CustomElevatedButton({
  //   super.key,
  // });

  final String text;

  // pageRoute 펑션 변수를 통한, "페이지 이동"
  // 원래는 [Function funPageRoute]와 같이 정의. "final"로 정의해도 동일.
  // final funPageRoute; // 6강
  final doRoutePage; // 나는 Function 이름을 "do + 동사"로 시작하게 한다.

  // const CustomElevatedButton({super.key, required this.text});
  const CustomElevatedButton({required this.text, required this.doRoutePage});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),

      // pageRoute 펑션 변수를 통한, "페이지 이동"
      onPressed: doRoutePage,
      // <=== pageRoute: ()=>Get.to(LoginPage()); 이런식으로 넘겨 주어야 한다.
      // onPressed: () {Get.to(LoginPage());},

      child: Text(
        "$text",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
