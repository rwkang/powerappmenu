/// 2023.08.06 Conclusion. Provider 역활: 통신이고, Repository 역활은 통신을 호출해서, 예쁘게 가공하는 일!!!
/// 왜 가공해야 하느냐면, JSON => Dart Object, 역변환을 해야 하기 때문이다.
/// 결론적으로 [Repository] 역활이라 함은?

/// => ***** 통신으로 받은 그 "엉망인" 데이터를, 정재하고 가공해서,
///          Frontend에서 잘 쓸 수 있도록, "Dart Object(Dto, Entity, ...)"로 바꾸는 역활 *****

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:powerappmenu/dto/ResponseDto.dart';
import 'package:powerappmenu/dto/PostRequestDto.dart';
import 'package:powerappmenu/util/ConvertUtf8ToObject.dart';

import '../../dto/LoginRequestDto.dart';
import 'Post.dart';
import 'PostProvider.dart';

class PostRepository {

  final PostProvider _postProvider = PostProvider();

  /// 2023.08.14 Added. Post.게시물 1개 추가:
  Future<Post> savePostRepository(String title, String content) async {
    PostRequestDto postRequestDto = PostRequestDto(title: title, content: content);

    Response response = await _postProvider.savePostProvider(postRequestDto.toJson());
    dynamic body = response.body;

    /// 한글 변환: 필요하면 이쪽에서 처리.

    /// 2023.08.14 Conclusion. 아래에서 Response.응답 받은 자료는, "글쓰기"로 추가된 1개의 row 정보이므로,
    /// 상단 postList 변수에 추가해 주기만 하면 된다. 굳이 전체 자료를 또 읽을 필요가 없다.
    ResponseDto responseDto = ResponseDto.fromJson(body);

    if (responseDto.code == 1) {
      print("/PostRepository.dart/글쓰기 성공");
      Post post = Post.fromJson(responseDto.data);
      return post;
    } else {
      print("/PostRepository.dart/글쓰기 실패");
      return Post();
    }

  }


  /// 2023.08.14 Added. Post.게시글 1개 수정: for /post/UpdatePage.dart/글 수정하기 버튼.
  Future<Post> updateByIdPostRepository(int id, String title, String content) async {
    PostRequestDto postRequestDto = PostRequestDto(title: title, content: content);

    Response response = await _postProvider.updateByIdPostProvider(id, postRequestDto.toJson());

    dynamic body = response.body;

    /// 한글 변환: 필요하면 이쪽에서 처리.

    ResponseDto responseDto = ResponseDto.fromJson(body);

    /// 수정이 완료되면,
    if (responseDto.code == 1) {
      print("/PostRepository.dart/수정 성공");
      Post post = Post.fromJson(responseDto.data);
      // print("1=====================================");
      // print("/repository/PostRepository/post.content: ${post.content}");
      return post;
    } else {
      print("/PostRepository.dart/수정 실패");
      return Post();
    }

  }


  /// 2023.08.13 Added. Post.게시글 1개만 삭제: for DetailPage().delete button.
  Future<int> deleteByIdPostRepository(int id) async {

    // if (id != null) {}

    Response response = await _postProvider.deleteByIdPostProvider(id);
    dynamic body = response.body;

    /// 한글 변환: 필요하면 이쪽에서 처리.

    ResponseDto responseDto = ResponseDto.fromJson(body);

    // return responseDto.code!;
    /// 혹시나 찜찜하면, 아래와 같이 ...
    return responseDto.code ?? -1;

  }


  /// 2023.08.10 Added. Post.게시글 1개만 가져오기: for DetailPage()
  Future<Post> findByIdPostRepository(int id) async {
  // Future<List<Post>> findByIdPostRepository(int id) async {

    Response response = await _postProvider.findByIdPostProvider(id);
    dynamic body = response.body;

    ResponseDto responseDto = ResponseDto.fromJson(body);

    /// 자료가 1개, 아래 2줄 필요가 없다. ***** 여기 주의 ***** List 변환도 필요 없다. 그냥 Post 타입으로 넘긴다.
    // List<dynamic> dataList = responseDto.data;
    // List<Post> postList = dataList.map((post) => Post.fromJson(post)).toList();

    if (responseDto.code == 1) {
      Post post = Post.fromJson(responseDto.data);
      return post;
    } else {
      return Post();
    }

  }


  /// Post.게시글 전체 자료 가져오기
  // Future<List<Map<String, dynamic>>> findAllPostRepository() async {
  Future<List<Post>> findAllPostRepository() async {
  // Future<String> findAll(String username, String password) async {
  // Future<void> findAll() async {

    Response response = await _postProvider.findAllPostProvider();

    dynamic body = response.body;

    /// 2023.08.10 Conclustion. convertUtf8ToObject() 펑션은, "한글이 깨졌을 때", 이것을 UTF-8 기준으로 한글화하는 것이데,
    /// 이미, 한글이 깨지지 않고, 잘 나오는 것이므로, 여기서 아래 펑션을 사용할 필요가 없다.
    // dynamic convertBody = convertUtf8ToObject(body); // UTF-8 한글 깨짐 해결

    // print("1=====================================");
    // print("/repository/PostRepository/response.headers: ${response.headers}"); /// {content-type: application/json;charset=utf-8, date: Mon, 07 Aug 2023 09:17:27 GMT, transfer-encoding: chunked, authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjb3PthqDtgbAiLCJpZCI6MSwiZXhwIjoxNjkxNDAzNDQ3fQ.J1FbnoFh2asF66cCex35H-LEZ0zOKfdj06L-hQP2HPIQRsefGLZSD1-1EDEOhOXzialk5AWIk1aiZ2RdQfeMHQ}
    // print("2=====================================");
    // print("/repository/PostRepository/response: ${response}"); /// Instance of 'Response<dynamic>'
    // print("/repository/PostRepository/response.runtimeType: ${response.runtimeType}"); /// Response<dynamic>
    // print("3=====================================");
    // print("body: ${body}"); // {code: 1, msg: success, data: {id: 1, username: ssar, password: null, email: ssar@nate.com, created: 2023-08-07T18:09:38, updated: 2023-08-07T18:09:38}}
    // print("body.runtimeType: ${body.runtimeType}"); /// _Map<String, dynamic> <=== ***** 여기가 핵심 ****
    // print("4=====================================");

    /// 2023.08.08 Conclusion. ResponseDto.dart 파일 생성하고, ResponseDto Object에 옮겨 답는다.
    /// 결론적으로, "_Map<String, dynamic>"와 같은 타입이여야 "ResponseDto Object"에 담을 수 있다. "List<dynamic>" 형식은 못 담는다.
    ResponseDto responseDto = ResponseDto.fromJson(body);

    // print("/repository/PostRepository/responseDto: ${responseDto}"); /// Instance of 'ResponseDto'
    // print("/repository/PostRepository/responseDto.runtimeType: ${responseDto.runtimeType}"); /// ResponseDto <=== *** 여기도 주의 ***
    // print("6=====================================");
    // // print("/repository/PostRepository/responseDto.code: ${responseDto.code}");
    // // print("/repository/PostRepository/responseDto.message: ${responseDto.message}");
    // // print("/repository/PostRepository/responseDto.data: ${responseDto.data}");
    // print("/repository/PostRepository/responseDto.data.runtimeType: ${responseDto.data.runtimeType}"); /// List<dynamic> <=== ***** 여기가 핵심 *****
    // print("7=====================================");

    if (responseDto.code == 1) {
      // print("8=====================================");

      /// 이렇게 하면 제일 좋은데, 불행하게도 "responseDto.data"는 "map"을 사용할 수 없다.
      // List<Post> posts = responseDto.data.map;
      /// 그러므로 아래와 같이 2단계로 처리해 주어야 한다.
      /// 1. List<dynamic> 타입으로 받고,
      /// 2. List<Post> 타입으로 받는다.

      List<dynamic> dataList = responseDto.data; /// List<dynamic> ===> 결국은 List<Post> 타입으로 리턴해야 한다.
      // dynamic dataList = responseDto.data; /// 이렇게는 못 받네.

      // print("9=====================================");
      // print("/repository/PostRepository/dataList.length: ${dataList.length}");
      // print("/repository/PostRepository/dataList.toString(): ${dataList.toString()}");
      // print("/repository/PostRepository/dataList.toList(): ${dataList.toList()}");
      // print("/repository/PostRepository/dataList.runtimeType: ${dataList.runtimeType}"); /// List<dynamic>
      // // print("/repository/PostRepository/dataList[0].title: ${dataList[0].title}");
      // print("10=====================================");

      // {
      //   id: 5,
      //   title: 제목5,
      //   content: 내용5,
      //   user: {
      //     id: 2,
      //     username: cos,
      //     password: 1234,
      //     email: cos@nate.com,
      //     created: 2023-14-08T15:14:47,
      //     updated: 2023-14-08T15:14:47
      //   },
      //   created: 2023-14-08T15:14:47,
      //   updated: 2023-14-08T15:14:47
      // }

      /// 2023.08.10 Conclusion. 결론적으로, "responseDto.data - List<dynamic>" 형식의 자료를
      ///                             ===> "postList - List<Post>" 형식의 자료에 담아 주는 것이 아래 로직이다.
      ///                                  또한 "List<Post>" 형식은 Post.java 파일에 가서 보면, Map<String, dynamic> 형식

      /// 1.
      // List<Post> postList = dataList.map((post){
      //   print("/repository/PostRepository/dataList.map.post: ${post}"); // {id: 5, title: 제목5, content: 내용5, user: {id: 2, username: cos, password: 1234, email: cos@nate.com, created: 2023-14-08T15:14:47, updated: 2023-14-08T15:14:47}, created: 2023-14-08T15:14:47, updated: 2023-14-08T15:14:47}
      //   print("/repository/PostRepository/dataList.map.post: ${post.runtimeType}"); // _Map<String, dynamic>
      //   print("IN =====================================");
      //   return Post.fromJson(post);
      // }).toList();
      /// 2. 위의 1.항 처럼 처리해도 동일한 결과.
      List<Post> postList = dataList.map((post) => Post.fromJson(post)).toList();

      // print("11=====================================");
      // print("/repository/PostRepository/postList.runtimeType: ${postList.runtimeType}"); /// List<Post>
      // print("/repository/PostRepository/postList.length: ${postList.length}");
      // print("/repository/PostRepository/postList[0].title: ${postList[0].title}");
      // // print("/repository/PostRepository/dataList[0].title: ${dataList[0].title}"); /// 여기 "dataList"는 이렇게 처리가 안 된다.
      // print("12=====================================");

      return postList;

    } else {

      /// List<Post> postList = []; return postList; 이와 같이 처리해도 된다.
      return <Post>[]; /// 빈 어레이 간단하게 처리하는 방법

    }

  }


/// 여기는 33강 내용 그대로...

// Future<List<Post>> findAllPostRepository() async {
//
//   Response response = await _postProvider.findAll();
//
//   dynamic body = response.body;
//
//   /// 2023.08.10 Conclustion. convertUtf8ToObject() 펑션은, "한글이 깨졌을 때", 이것을 UTF-8 기준으로 한글화하는 것이데,
//   /// 이미, 한글이 깨지지 않고, 잘 나오는 것이므로, 여기서 아래 펑션을 사용할 필요가 없다.
//   // dynamic convertBody = convertUtf8ToObject(body); // UTF-8 한글 깨짐 해결
//
//   print("0=====================================");
//   print("/repository/PostRepository/body: ${body}");
//   print("/repository/PostRepository/body.runtimeType: ${body.runtimeType}"); /// _Map<String, dynamic>
//   print("1=====================================");
//   print("/repository/PostRepository/body['data']: ${body['data']}");
//   print("/repository/PostRepository/body['data'].runtimeType: ${body['data'].runtimeType}"); /// List<dynamic>
//   print("2=====================================");
//
//   ResponseDto responseDto = ResponseDto.fromJson(body);
//
//   // print(responseDto.runtimeType); /// cmRespDto
//   // print(responseDto.code);
//   // print(responseDto.message);
//   // print("/repository/PostRepository/cmRespDto.data: ${responseDto.data}"); ///
//   // print("/repository/PostRepository/cmRespDto.data.runtimeType: ${responseDto.data.runtimeType}"); /// List<dynamic>
//   // print(responseDto.data.runtimeType); /// _Map<String, dynamic>
//   // print("3=====================================");
//
//   if (responseDto.code == 1) {
//
//     /// 1.
//     // List<Post> postList = (responseDto.data as List)
//     //     .map((itemWord) => Post.fromJson(itemWord))
//     //     .toList();
//     /// 2.
//     // List<Post> postList = (body['data'] as List).map((itemWord) => Post.fromJson(itemWord)).toList();
//     /// 3. 상기 1. 2. 3. 항은 모두 동일한 결과
//     List<Post> postList = (responseDto.data as List).map((itemWord) => Post.fromJson(itemWord)).toList();
//
//     print("/repository/PostRepository/post.runtimeType: ${postList.runtimeType}"); /// List<Post>
//     print("22=====================================");
//
//     // List<dynamic> dataList = responseDto.data;
//     // print("/repository/PostRepository/dataList.runtimeType: ${dataList.runtimeType}"); /// List<dynamic>
//     // print("4=====================================");
//
//     // List<Post> postList = dataList.map((post) => Post.fromJson(post)).toList();
//
//     // List<Post> postList = dataList.map((post) {
//     //   print("/repository/PostRepository/post: ${post}"); /// {id: 2, title: 제목2, content: 내용2, user: {id: 1, username: ssar, password: 1234, email: ssar@nate.com, created: 2023-07-10T17:07:38, updated: 2023-07-10T17:07:38}, created: 2023-07-10T17:07:38, updated: 2023-07-10T17:07:38}
//     //   print("/repository/PostRepository/post.runtimeType: ${post.runtimeType}"); /// _Map<String, dynamic>
//     //   return Post.fromJson(post);
//     // }).toList();
//
//     print("/repository/PostRepository/postList.runtimeType: ${postList.runtimeType}"); /// List<Post>
//     print("5=====================================");
//
//
//     return postList;
//   } else {
//     //List<Post> hello = [];
//     return <Post>[];
//   }
// }



}