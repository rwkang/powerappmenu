import 'package:get/get.dart';

import '../domain/user/UserRepository.dart';
import '../util/Jwt.dart';

class UserController extends GetxController {

  final UserRepository _userRepository = UserRepository();
  // final _userRepository = UserRepository(); // 타입 생략 가능

  // 2023.08.08 Added. Login.로그인 상태 관리.
  final RxBool isLogin = false.obs; // UI가 관찰 가능한 변수 => 변경 => UI가 자동으로 업데이트 한다.
  // final isLogin = false.obs; // 타입 생략 가능

  // 2023.08.08 Added. 예를 들어, /controller/UserController.dart 파일에, isLogin 변수 값을 "false"로 강제 변경하는 메소드를 만들고,
  // 아래 "+" 아이콘을 클리하면, 해당 forceChangeFalseInIsLogin() 메소드를 실행하게 해 본다.

  void forceChangeFalseInIsLogin() {
    isLogin.value = false;
  }

  // 2023.08.08 Added. /view/components/LeftMenu.dart/Logout 버튼을 클릭하면,
  // Login.로그인 페이지로 가기 전에,
  // 반드시, 아래 내용을 먼저 초기화 해 주어야 한다.
  // 1> 상태 관리 초기화: isLogin.value = false;
  // 2> 토큰 초기화: jwtToken = null;
  // 이를 위하여, 상단에 UserController userController = Get.find(); 선언을 해 주어야 한다.
  // userController.isLogin.value = false;
  // jwtToken = null;
  // ===> 그런데,
  // 로그아웃 클릭 이벤트에서 위와 같이 자질구레하게 처리하는 것 보다,
  // UserController.dart 파일에서, 펑션 처리하고, 여기서는 그 펑션만 호출하는 것이 매우 깔끔하다 할 수 있겠다.

  void logout() {
    isLogin.value = false;
    jwtToken = null;
  }


  Future<String> login(String username, String password) async {
  // Future<void> login(String username, String password) async {
    String token = await _userRepository.login(username, password);

    // 2023.08.07 Conclusion. 위에서 받은 "token"을 폰 내부의 "Shared Preferences"에 저장할 수 있는데,
    // 폰이 꺼져도 계속 영구적으로 저장되어 있다. 단, "token"의 유효 시간인 1시간까지 임에 주의.
    // ∴> 그러므로 이것을 "/util/Jwt.dart" 파일에 저장한다.

    if (token!= "-1") {

      // Login.로그인 성공시, 상태 관리 변경... RxBool 타입은 꼭 ".value" 형식으로 사용.
      isLogin.value = true;

      jwtToken = token;

    } else {
      // 여기는 token 값이 null 이다.
    }

    print("/controller/UserController.dart=====================================");
    print("/controller/UserController.dart/token: ${token}"); // Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjb3PthqDtgbAiLCJpZCI6MSwiZXhwIjoxNjkxNDA2MDgzfQ.Uqn2EDU5lQDIWuDKD9RrGfeh4RiPRhDWMbgwY3dAqyRRvcpybaVF9Vj7viFYxSA57Xp56jrgen8mhXCUinhjVA

    return token;

  }

}

