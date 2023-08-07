import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:powerappmenu/controller/UserController.dart';
import 'package:powerappmenu/domain/user/UserRepository.dart';
import 'package:powerappmenu/util/ValidatorUtil.dart';

import '../../components/CustomElevatedButton.dart';
import '../../components/CustomTextFormField.dart';
import '../post/HomePage.dart';
import 'JoinPage.dart';

class LoginPage extends StatelessWidget {
  // const LoginPage({super.key});

  // validators Dependency Injection 한 후,
  // "Form State global Key.폼 상태 관리용 클로벌 키" 정의
  final _formKey = GlobalKey<FormState>();

  // 2023.08.07 Conclusion. Controller 세팅한 후, 아래와 같이,
  // 반드시 "Get.put()"으로, 이쪽에서 선언해 주고, 아래에서 호출한다.
  final UserController userController = Get.put(UserController());

  // 2023.08.07 Conclusion. 일반적으로 객체 타입을 동일하게 맟춰주면서, Object를 생성하는데,
  // 이 Type타입은 "생략"이 가능하다 => 타입 추론
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // => 타입 추론으로 Type 생략
  // final _usernameController = TextEditingController();
  // final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // 2023.08.05 Conclusion. ListView 위젯을 쓰는 이유는, 아래에서 "키보드"가 올라오면서,
      // 자동으로 "스크롤"이 되어야 한다.
      // 자동 스크롤이 안 되면, 나중에 화면이 깨지는 위험이 있을 수 있다.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 50,
              child: Text(
                // "로그인 페이지",
                "로그인 페이지 ${userController.isLogin.value}",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // 2023.08.05 Conclusion. 사용자에게서 입력 받은 3개 정보를 서보로 보낼 때,
            // "한꺼번"에 보내기 위해서는 반드시 "Form" 위젯으로 묶어서 사용해야 한다.
            // 유효성 검사 등 필요
            _loginForm(),
            // const Divider(),
          ],
        ),
      ),
    );
  }

  // 2023.08.05 Conclusion. 사용자에게서 입력 받은 3개 정보를 서보로 보낼 때,
  // "한꺼번"에 보내기 위해서는 반드시 "Form" 위젯으로 묶어서 사용해야
  // "Refact" 한 후 메드는 반드시 "Widget" 타입, 즉 "최상위 부모" 타입으로 변경해 준다.
  // Form _joinForm() {
  Widget _loginForm() {
    return Form(
      // 상단에서 "Form State global Key.폼 상태 관리용 클로벌 키" 정의 한 후,
      // 여기서 아래와 같이 "Key 세팅"을 하면, "현재 From 상태"를 관리할 수 있다.
      // 또한 *** 여기 펑션 외부에서까지도 *** 관리할 수 있다.
      key: _formKey,

      child: Column(
        children: [
          CustomTextFormField(
            controller: _usernameController,
            hint: "User Name",
            doValidateFormField: doValidateUserName(),
          ),
          CustomTextFormField(
            controller: _passwordController,
            hint: "Password",
            doValidateFormField: doValidatePassword(),
          ),
          // CustomElevatedButton()에서 pageRoute 펑션 변수를 통한, "페이지 이동"
          CustomElevatedButton(
              text: "로그인",
              doRoutePage: () async {
                if (_formKey.currentState!.validate()) {
                  // 2023.08.05 Conclusion. 실제로는 "Controller.login()"을 호출해야 한다.
                  // 아래 직접 호출한 것은, 잠시 테스트만 해 본다.
                  // UserRepository u = UserRepository();
                  // u.login("ssar", "1234");

                  // 2023.08.07 Conclusion. userController.login()에서 return.리턴한 값을 받을 수 있다.
                  // 단, 여기서도 받을려면, 반드시 "async" <=> "await" 상태로 구분 자체를 수정해 주어야 한다.
                  String token = await userController.login(
                    _usernameController.text.trim(),
                    _passwordController.text.trim(),
                  );

                  // if (token.isNotEmpty) {
                  if (token != "-1") {
                    Get.to(() => HomePage());
                  } else {
                    // 로그인 실패에 대한 "Popup Window" 띄우기.
                    Get.snackbar("로그인 시도", "로그인 실패");
                  }

                  // userController.login(_usernameController.text.trim(), _passwordController.text.trim());
                  // userController.login("ssar", "1234");

                  //Get.to(() => HomePage());
                  // Get.to(()=> JoinPage());

                  print(
                      "/user/LoginPage.dart/CustomElevatedButton.로그인 클릭 후 받은 token: ${token}");
                }
              }),
          // param이 2개 이상일 때.
          // text: "로그인", doRoutePage: () => Get.to(JoinPage())), // param이 1개일 때.
          const Divider(),
          TextButton(
            onPressed: () {
              Get.to(() => JoinPage());
            },
            child: const Text(
              "신규 사용자 인가요?",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
