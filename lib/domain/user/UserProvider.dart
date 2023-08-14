// 2023.08.06 Conclusion. Provider 역활: 통신이고, Repository 역활은 통신을 호출해서, 예쁘게 가공하는 일!!!

// 2023.08.06 Conclusion. 현재 테스트 하고 있는 , Emulator.에뮬레이터는 IP 주소가 다름에 특히 주의할 것.

// Spring Boot JWT Server Port: 8080
import 'package:get/get.dart';

const host = "http://192.168.0.8:8080";
// const host = "http://192.168.0.8:8080/login";

// print("/domain/user/UserProvider.dart/UserProvider.host: ${host}");
class UserProvider extends GetConnect {

  // Promise (Response.응답 받기로 약속) => Repository에서 받는다.

  /// Future<Response> loginProvider(Map data) => post("$host/login", data); // 아래와 100% 동일.
  Future<Response> loginProvider(Map data) { /// 위의 1줄 라인을 풀어 쓰는 것이다. print() 문 사용을 위해...

    print("=====>/domain/user/UserProvider.dart/UserProvider.host: ${host}");
    print("=====>/domain/user/UserProvider.dart/UserProvider.data: ${data}");

    return post("$host/login", data);

  }

}
