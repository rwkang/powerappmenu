import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:powerappmenu/util/ValidatorUtil.dart';

import '../../components/CustomElevatedButton.dart';
import '../../components/CustomTextArea.dart';
import '../../components/CustomTextFormField.dart';
import 'HomePage.dart';

class WritePage extends StatelessWidget {
  // const WritePage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          // child: Column( // Overflow Error 방지를 위해, 아래 "ListView" 위젯을 사용
          child: ListView(
            children: [
              CustomTextFormField(
                hint: "Title",
                doValidateFormField: doValidateTitle(),
                value: "제목 ???",
              ),
              CustomTextArea(
                hint: "Content",
                doValidateFormField: doValidateContent(),
                value: "내용 1" * 20,
              ),
              CustomElevatedButton(
                text: "글 쓰기",
                doRoutePage: () {
                  if (_formKey.currentState!.validate()) {
                    Get.off(HomePage());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
