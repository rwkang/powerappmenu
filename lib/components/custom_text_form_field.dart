
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  // const CustomTextFormField({
  //   super.key,
  // });

  final String hint;

  // doValidateForm 펑션 변수를 통한, "유효성 검사"
  // 원래는 [Function funValidator]와 같이 정의. "final"로 정의해도 동일.
  // final funValidator; // 6강
  // validators Dependency Injection 한 후,
  // "Form State global Key.폼 상태 관리용 클로벌 키" 정의
  final doValidateFormField;

  // const CustomTextFormField({super.key, required this.hint});
  const CustomTextFormField({required this.hint, required this.doValidateFormField});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(

        // validation
        validator: doValidateFormField,

        // hist 구분
        obscureText: hint == "Password" ? true : false,

        decoration: InputDecoration(
          // 2023.08.05 Conclusion. 변수 대입은 "" - 따옴표 안에 "$"와 함께 사용하는 습관이 좋다.
          hintText: "Enter $hint",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )
        ),
      ),
    );
  }
}
