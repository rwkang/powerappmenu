import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:powerappmenu/util/ValidatorUtil.dart';

import '../../../controller/PostController.dart';
import '../../components/CustomElevatedButton.dart';
import '../../components/CustomTextArea.dart';
import '../../components/CustomTextFormField.dart';

class UpdatePage extends StatelessWidget {
//   const UpdatePage({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  /// 2023.08.14 Conclusion. DetailPage.수정 버튼에서, Post 전체 정보를 보내도 되지만,
  /// 여기 UpdatePage()에서, Get.find()로 찾아서 처리할 수 있다.
  /// ∵) Post 정보를 Obs()에서 항상 관리하고 있기 때문에, 어디에서도 Get.find()할 수 있다.

  PostController postController = Get.find();

  @override
  Widget build(BuildContext context) {

    print("/UpdatePage.dart/_titleController.text: ${_titleController.text}");
    print("/UpdatePage.dart/_titleController: ${_titleController}");
    print("/UpdatePage.dart/_titleController: ${_contentController}");
    print("0==================================================================");

    /// 2023.08.14 Conclusion. "controller.컨트롤러"와 "initialValue.초기 값"은
    /// 2023.08.14 Conclusion. "Controller.컨트롤러"와 "initialValue.초기값"을 함꼐 넘길 수 없다.
    /// 꼭 함께 넘겨야 할 상황에서는, "넘기는 쪽"에서 다음과 같이, "컨트롤러 변수명.text"로 넘여야 한다.

    _titleController.text = "${postController.post.value.title}";
    _contentController.text = "${postController.post.value.content}";

    print("/UpdatePage.dart/_titleController.text: ${_titleController.text}");
    print("/UpdatePage.dart/_titleController.text: ${_contentController.text}");
    print("/UpdatePage.dart/_titleController: ${_titleController}");
    print("/UpdatePage.dart/_titleController: ${_contentController}");
    print("0==================================================================");

    return Scaffold(
      appBar: AppBar(
        title: Text("글 수정"),
      ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            // child: Column( // Overflow Error 방지를 위해, 아래 "ListView" 위젯을 사용
            child: ListView(
              children: [
                CustomTextFormField(

                  controller: _titleController,

                  // value: "제목 1",

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
                  text: "글 수정하기",
                  doRoutePage: () async {
                    if (_formKey.currentState!.validate()) {

                      /// 2023.08.14 Added. Update DB.
                      await postController.updateByIdPostController(postController.post.value.id!, _titleController.text, _contentController.text);
                      // await postController.updateByIdPostController(postController.post.value.id ?? 0, _titleController.text, _contentController.text);


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
