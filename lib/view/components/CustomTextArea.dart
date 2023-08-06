
import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
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

  // "글 수정하기"와 같이, 초기에 반드시 어떤 내용을 가져가서 뿌려야 하는 경우,
  // 아래 "initialValue"를 사용한다.
  final String? value; // 받아도 되고, 안 받아도 되고, 즉, "required" 아닐 때, "?" 필수.

  // const CustomTextFormField({super.key, required this.hint});
  const CustomTextArea({required this.hint, required this.doValidateFormField, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(

        maxLines: 10,

        // "글 수정하기"와 같이, 초기에 반드시 어떤 내용을 가져가서 뿌려야 하는 경우,
        // 아래 "initialValue"를 사용한다.
        initialValue: "$value", // 또한 "null" 때문에 오류 위험.
        // initialValue: value ?? "", // 또한 "null" 때문에 오류 위험.
        //initialValue: "초기 값", // 또한 "null" 때문에 오류 위험.

        // validation
        validator: doValidateFormField,

        decoration: InputDecoration(
          // 2023.08.05 Conclusion. 변수 대입은 "" - 따옴표 안에 "$"와 함께 사용하는 습관이 좋다.
            hintText: "Enter $hint",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            )
        ),
      ),
    );
  }
}
