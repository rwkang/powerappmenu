import 'package:get/get.dart';
import 'package:powerappmenu/domain/post/PostRepository.dart';

import '../domain/post/Post.dart';

class PostController extends GetxController {

  final PostRepository _postRepository = PostRepository();

  /// 그러므로 상단에서, "관찰 가능한 obs" 변수를 선언하고, 그것으로 처리하게 해야 한다.
  final postList = <Post>[].obs;
  final post = Post().obs;

  /// 2023.08.08 Added. HomePage.java 파일에서,
  /// 이렇게 PostController postController = Get.put(PostController()); 선언하면,
  ///
  /// /controller/PostController.java 파일은, 2가지 일을 하는데, Console.콘솔 박스에서 확인할 수 있다.
  /// 1. [GETX] Instance "PostController" has been created
  /// 2. [GETX] Instance "PostController" has been initialized
  /// 위와 같이 "created.생성"과 "initialized.초기화(onInit())"를 실행한다.
  ///
  /// 결론적으로, 아래 onInit()에서 findAllPostRepositor()를 실행해서, 초기화 동시에 자료를 가져오게 한다.

  /// Ctrl + O or Alt + insert Key/Override Methods/onInit Method 엔터
  @override
  void onInit() {
    super.onInit();
    print("안녕! /PostController.java/onInit()에서 자동 초기화(findAllPostController()) 펑션을 실행한다!!!");

    findAllPostController(); /// 초기화 하면서, 실행하게 한다.

  }


  /// 2023.08.14 Added. Post.게시물 1개 추가:
  Future<void> savePostController(String title, String content) async {
    Post post = await _postRepository.savePostRepository(title, content);

    if (post.id != null) {

      print("/PostController.dart/savePostController.post: ${post}");
      print("1=====================================");

      postList.add(post);

      print("/PostController.dart/savePostController.postList: ${postList}");

    }
  }


  /// 2023.08.14 Added. Post.게시물 1개만 수정.
  Future<void> updateByIdPostController(int id, String title, String content) async {
    Post post = await _postRepository.updateByIdPostRepository(id, title, content);

    // print("/PostController.dart/post: ${post}");
    // print("/PostController.dart/post.id: ${post.id}");
    // print("/PostController.dart/post.title: ${post.title}");
    // print("/PostController.dart/post.content: ${post.content}");
    // print("0=====================================");

    if (post.id != null) { /// 수정 성공

      /// 2023.08.14 Conclusion. 여기서 상당히 중요한 것은,
      /// 아래 [this.post.value = post] 구문으로, 상단에 정의한 "post" 값을 변경함과 동시에,
      /// 이것을 Obx()로 관찰하고 있는 DetailPage().수정 버튼.Get.back()에서는, 자동으로 변경된 값으로 뿌려지게 된다는 것이다.
      /// 그러나, HomePage()에서는, "상단 post"가 아닌, "상단 postList"를 Obx()로 관찰하고 있기 때문에, 변경되지 않는다.
      /// ===> 이것을 해결하기 위해서는 "상단 postList" 값도 당연히 변경해 주어야 한다.
      /// map() 펑션으로 돌면서, 수정된 row는 수정된 정보로 바꿔주고, 나머지 row는 그대로 유지해 준다.

      this.post.value = post;

      List<Post> dataList = postList.map((e) => e.id == id ? post : e).toList();
      // List dataList = postList.map((e) => e.id == id ? {...e, post : e}).toList();

      // print("11=====================================");
      // print("/controller/PostController/postList.runtimeType: ${postList.runtimeType}"); /// RxList<Post>
      // print("/controller/PostController/postList.length: ${postList.length}");
      // postList.forEach((element) {
      //   print("/controller/PostController/postList.id 수정 전: ${element.id}");
      //   print("/controller/PostController/postList.title 수정 전: ${element.title}");
      //   print("/controller/PostController/postList.content 수정 전: ${element.content}");
      // });
      // print("12=====================================");

      postList.value = dataList;

      // postList.forEach((element) {
      //   print("/controller/PostController/postList.id 수정 후: ${element.id}");
      //   print("/controller/PostController/postList.title 수정 후: ${element.title}");
      //   print("/controller/PostController/postList.content 수정 후: ${element.content}");
      // });
      // print("13=====================================");

      /// 아래와 같이 처리해도 동일.
      // postList.value = postList.map((e) => e.id == id ? post : e).toList();

      /// 2023.08.14 정규 연산자

      // var list = [{"id": 1}, {"id": 2}];
      // var subList = list;
      // var newList = list.map((e) => {...e}).toList();
      // print("/PostController.dart/정규 연산자 테스트 1: ${subList}");
      // print("/PostController.dart/정규 연산자 테스트 2: ${newList}");
      //
      // list[0]["id"] = 10;
      // print("/PostController.dart/정규 연산자 테스트 3: ${list}");
      // print("/PostController.dart/정규 연산자 테스트 4: ${newList}");
      //
      // print("/PostController.dart/정규 연산자 테스트 5: ${list.hashCode}");
      // print("/PostController.dart/정규 연산자 테스트 6: ${newList.hashCode}");
      // print("/PostController.dart/정규 연산자 테스트 7: ${subList.hashCode}");
      //
      // var users = [
      //   {"id": 1, "name": "cos", "email": "cos@example.com", "password": 1234},
      //   {"id": 2, "name": "ssar", "email": "ssar@example.com", "password": 5678},
      // ];
      //
      // var newUsers = users.map((e) => e["id"] == id ? {...e} : e).toList();
      // print("/PostController.dart/정규 연산자 테스트 9: ${newUsers}");

    }

  }


  /// 2023.08.13 Added. Post.게시물 1개만 삭제.
  /// 여기서 중요한 것은, ***** 다시 "Post 테이블 정보"를 가져 올 필요는 없는데, 상단 "postList 정보"를 반드시 갱신시켜 주어야 한다는 것이다 *****

  Future<void> deleteByIdPostController(int id) async {

    int result = await _postRepository.deleteByIdPostRepository(id);

    if (result == 1) {
      print("/controller/PostController.java/서버 Post ${id} 삭제 성공!!!");

      /// 2023.08.14 Conclusion. 1개 게시물 삭제 후,
      /// ***** 다시 "Post 테이블 정보"를 가져 올 필요는 없는데, 상단 "postList 정보"를 반드시 갱신시켜 주어야 한다는 것이다 *****

      List<Post> resultList = postList.where((post) => post.id != id).toList();

      // print("1=====================================");
      // print("/controller/PostRepository/resultList: ${resultList}"); ///
      // print("/controller/PostRepository/postList: ${postList}"); ///

      postList.value = resultList;

      // print("/controller/PostRepository/postList: ${postList}"); ///

    }

  }


  /// 2023.08.10 Added. Post.게시글 1개만 가져오기: for DetailPage()
  Future<void> findByIdPostController(int id) async {
    Post post = await _postRepository.findByIdPostRepository(id);

    this.post.value = post; /// 여기서 this 의미는 최상단 class 변수 "postList"를 가리킨다.

  }


  /// Post.게시글 전체 자료 가져오기
  // Future<List<Post>> findAllPostRepositor() async {
  Future<void> findAllPostController() async {
  // void findAll() async {

    List<Post> postList = await _postRepository.findAllPostRepository();

    // print("1=====================================");
    // print("/controller/PostRepository/postList.runtimeType: ${postList.runtimeType}"); /// List<Post>
    // print("/controller/PostRepository/postList.length: ${postList.length}");
    // print("/controller/PostRepository/postList[0].title: ${postList[0].title}");
    // print("1=====================================");

    /// 호출하는 HomePage 쪽으로 돌려 준다. 그런데, HomePage에 다음과 같은 문제가 있다.
    /*
    /// 2023.08.10 Added. /controller/PostController.java 파일에서 넘어온 자료를,
    /// 여기서 뿌려 줘야 하는데,
    ///
    /// 1. 여기 이 부분에서 다음 구문을 실행하게 되면, "awit"를 걸어 줘야 하는데,
    ///    그러면, Widget build(BuildContext context) 여기에 "async"를 반드시 같이 걸어 줘야 하는데,
    ///    그렣게 되면, "Widget build()"가 화면 UI를 그려야 되는데,
    ///    "await" 때문에 그리질 못하고, 기다리게 된다. 그러면 UI가 엉망이 된다.
    ///    List<Post> postList = await postController.findAll();
    ///
    ///    즉, "Widget build()" 처럼 UI를 그리는 것이 아니라,
    ///    받은 데이터를 기준으로 "if 구문" 분기를 위해서 사용하는 것 등은,
    ///    여기서 바로 "async/await"를 사용해도 된다.
    */

    /// 그러므로 상단에서, "관찰 가능한 obs" 변수를 선언하고, 그것의 ".value" 속성에 담아 두는 것으로 처리하게 해야 한다.
    this.postList.value = postList; /// 여기서 this 의미는 최상단 class 변수 "postList"를 가리킨다.

  }

}