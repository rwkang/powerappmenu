

import 'package:get/get.dart';
import 'package:powerappmenu/util/Jwt.dart';

const host = "http://192.168.0.8:8080";

// 통신
class PostProvider extends GetConnect {

  /// 2023.08.14 Added. Post.게시물 1개 추가:
  Future<Response> savePostProvider(Map data) => post("$host/post", data, headers: {"Authorization": jwtToken ?? ""});

  /// 2023.08.14 Added. Post.게시물 1개 수정: argument(int id, Map data) 특히 이 부분 주의.
  Future<Response> updateByIdPostProvider(int id, Map data) => put("$host/post/$id", data, headers: {"Authorization": jwtToken ?? ""});

  /// 2023.08.14 Conclusion. ***** get("$host/post/$id", ~~) 여기서, "post" 이것을 "delete"로 잘 못 기재할 수 있음에 특히 주의 *****

  /// 2023.08.13 Added. Post.게시물 1개만 삭제: for DetailPages.delete button.
  Future<Response> deleteByIdPostProvider(int id) => delete("$host/post/$id", headers: {"Authorization": jwtToken ?? ""});
  // Future<Response> deleteByIdPostProvider(int id) => delete("$host/delete/$id", headers: {"Authorization": jwtToken ?? ""});

  /// 위의 펑션을 아래와 같이 풀어 쓸 수 있다.
  // Future<Response> deleteByIdPostProvider(int id) {
  //
  //   return get("$host/post/$id", headers: {"Authorization": jwtToken ?? ""});
  //   // return get("$host/delete/$id", headers: {"Authorization": jwtToken ?? ""});
  //
  // }

    /// 2023.08.10 Added. Post.게시글 1개만 가져오기: for DetailPage(): param 1개이면, 중괄호 ${id} 생략 가능.
    Future<Response> findByIdPostProvider(int id) => get("$host/post/$id", headers: {"Authorization": jwtToken ?? ""});
    // Future<Response> findById(int id) => get(("$host/post/${id}", headers: {"Authorization": jwtToken ?? ""});


    // Promise (데이터 약속)
    Future<Response> findAllPostProvider() => get("$host/post", headers: {"Authorization": jwtToken ?? ""});

}