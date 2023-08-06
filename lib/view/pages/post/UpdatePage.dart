import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:powerappmenu/util/ValidatorUtil.dart';

import '../../components/CustomElevatedButton.dart';
import '../../components/CustomTextArea.dart';
import '../../components/CustomTextFormField.dart';

class UpdatePage extends StatelessWidget {
  // const UpdatePage({super.key});

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
                value: "제목 1",
              ),
              CustomTextArea(
                hint: "Content",
                doValidateFormField: doValidateContent(),
                value: "내용 1" * 20,
              ),
              CustomElevatedButton(
                text: "글 수정하기",
                doRoutePage: () {
                  if (_formKey.currentState!.validate()) {

                    // HomePage -> DetailPage -> DetailPage -> UpdatePage ->

                    // 2023.08.06 Conclusion. 뒤로 가기 ← 아이콘 정리.
                    // 1. 문제
                    //    1> DetailPage.수정 버튼을 Get.off(UpdatePage()) 주고,
                    //    2> 여기 UpdatePage.글 수정하기 버튼을 Get.off(DetailPage())로 주면,
                    //    => UpdatePage에서 글 수정하기 버튼을 안 누르고, 즉, UpdatePage 들어 가자마자 바로 "뒤로 가기 ← 아이콘"을 클릭하면,
                    //       "DetailPage"로 안 가고, HomePage로 가 버리는 문제가 있다.
                    // 2. 문제
                    //    1> DetailPage.수정 버튼을 Get.to(UpdatePage()) 주고,
                    //    2> 여기 UpdatePage.글 수정하기 버튼을 Get.off(DetailPage())로 주면,
                    //    => UpdatePage에서 글 수정하기 버튼을 클릭하면, 바로 DetailPage 돌아 오는데,
                    //       여기서 "뒤로 가기 ← 아이콘"을 클릭하면,
                    //       "HomePage"로 바로 못 가고, 2-3번 "DetailPage"로 계속 이동한다는 문제가 있다.
                    // 3. 결론
                    //    1> DetailPage.수정 버튼을 Get.to(UpdatePage()) 주고,
                    //    2> 여기 UpdatePage.글 수정하기 버튼을 Get.back()로 주면,
                    //    => "뒤로 가기 ← 아이콘" 문제는 없고, 다만, 데이터 갱신에 문제가 있을 수 있는데,
                    //       이 문제는 "상태 관리"에서 처리하면 된다.

                    Get.back(); // 2023.08.06 Conclusion. "글 수정하기"에서 처리된 데이터를 "갱신" 하는 것은, "상태 관리"에서 처리하면 된다.
                    // Get.off(DetailPage(id: 1));
                    // Get.to(DetailPage(id: 1));
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
