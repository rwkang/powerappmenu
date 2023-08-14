import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:powerappmenu/controller/PostController.dart';
import 'package:powerappmenu/util/ValidatorUtil.dart';

import '../../components/CustomElevatedButton.dart';
import '../../components/CustomTextArea.dart';
import '../../components/CustomTextFormField.dart';
import 'HomePage.dart';


class WritePage extends StatelessWidget {
  // const WritePage({super.key});
  
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  
  PostController postController = Get.find();

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

                controller: _titleController,

                // value: "제목 ???",

                hint: "Title",
                doValidateFormField: doValidateTitle(),
              ),
              CustomTextArea(

                controller: _contentController,

                // value: "내용 1" * 20,

                hint: "Content",
                doValidateFormField: doValidateContent(),
              ),

              CustomElevatedButton(
                text: "글 쓰기",
                doRoutePage: () async { /// 3초 걸리는 시간 동안 "로딩 아이콘" 표시
                  if (_formKey.currentState!.validate()) {

                    /// 2023.08.14 Added. Connect DB.
                    /// 만약, 여기 딱 1곳에서만 사용한다면, 상단에 정의하지 않고, 아래와 같이 1줄로 사용할 수도 있다.
                    /// Get.find<PostController>().savePostController(_titleController.text.trim(), _contentController.text.trim());
                    await postController.savePostController(_titleController.text, _contentController.text); /// UserId 또는 Email 이런 것만 trim() 한다.
                    // await postController.savePostController(_titleController.text.trim(), _contentController.text.trim());

                    Get.off(() => HomePage());

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
