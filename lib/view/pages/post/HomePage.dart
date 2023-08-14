import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:powerappmenu/controller/PostController.dart';
import 'package:powerappmenu/size.dart';
import 'package:powerappmenu/view/pages/post/WritePage.dart';
import 'package:powerappmenu/view/pages/user/LoginPage.dart';
import 'package:powerappmenu/view/pages/user/UserInfo.dart';
import '../../../controller/UserController.dart';
import '../../components/LeftMenu.dart';
import 'DetailPage.dart';

class HomePage extends StatelessWidget {
  // const HomePage({super.key});

  /// 2023.08.14 Conclusion. Navigatior 제어하기 위해서는,
  /// 상단에서 "Scaffold Key"를 먼저 만들어서, 아래 버튼에서 제어하면 된다.
  var scaffoldKey = GlobalKey<ScaffoldState>();

  /// 2023.08.14 Added. 현재 홈 페이지에 뿌려진 리스트 데이터를 "Refresh"하는 기능 추가
  var refreshKey = GlobalKey<RefreshIndicatorState>();


  // 20230.08.08 Added. /controller/UserController.dart/RxBool isLogin 상태 관리 확인을 위한 임시...
  // 30강서는, 여기 "Widget" 안에서도 선언 가능하다고 했는데, 현재는 여기서는 안 되고, 반드시 상단, "class" 안에 넣어야 하네...

  // Get.put() : 없으면 새로 만들고, 있으면 찾아라는 것이므로, 여기서는 .find()를 사용한다.
  // UserController userController = Get.put(UserController());
  UserController userController = Get.find();

  /// 2023.08.08 Added. /controller/PostController.java 파일을 여기서 선언하면, 2가지 일을 하는데, Console.콘솔 박스에서 확인할 수 있다.
  /// 1. [GETX] Instance "PostController" has been created
  /// 2. [GETX] Instance "PostController" has been initialized
  /// 위와 같이 "created.생성"과 "initialized.초기화(onInit())"를 실행한다.

  PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {

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
    ///
    ///    그러므로 사용을 위해서는 먼저 "/controller/PostController.java" 파일에서,
    ///    "관찰 가능한 변수" obs()를 선언하고, 그 변수에 자료를 담은 다음,
    ///
    ///    그리고는 실제 필요한 곳(ListView)에서, Obx(()=>ListView()) 안에서 처리하게 한다.

    print("/HomePage.dart/scaffoldKey: ${scaffoldKey}");

    return Scaffold(

      /// 2023.08.14 Conclusion. Navigatior 제어하기 위해서는,
      /// 상단에서 "Scaffold Key"를 먼저 만들어서, 아래 버튼에서 제어하면 된다.

      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (scaffoldKey.currentState!.isDrawerOpen) {
            print("drawer is open");
            scaffoldKey.currentState!.openEndDrawer();
          } else {
            print("drawer is closed");
            scaffoldKey.currentState!.openDrawer();
          }
        },
        child: const Icon(Icons.code),
      ),

      /// 20230.08.08 Added. /controller/UserController.dart/RxBool isLogin 상태 관리 확인을 위한 임시...
      /// 30강서는, 여기 "Widget" 안에서도 선언 가능하다고 했는데, 현재는 여기서는 안 되고, 반드시 상단, "class" 안에 넣어야 하네...

      /// Get.put() : 없으면 새로 만들고, 있으면 찾아라는 것이므로, 여기서는 .find()를 사용한다.
      /// UserController userController = Get.put(UserController());
      /// UserController userController = Get.find();

      /// AppBar()는 자동으로 "뒤로 가기.←" 아이콘이 생성되는데,
      /// 그것을 못 뜨게 "Container" 위젯으로 Left Menu.왼쪽 메뉴 컨테이너를 둔다.
      drawer: LeftMenu(),
      // drawer: _navigation(context),

      appBar: AppBar(

        /// 20230.08.08 Added. /controller/UserController.dart/RxBool isLogin 상태 관리 확인을 위한 임시...
        /// title: Text("로그인 상태 ===> ${userController.isLogin.value}"), // ===> 아래 참조.
        /// 그럼 어떻게 처리해야 UI가 상태를 변경할 수 있을까? 그것은 간단하게도,
        /// 상기 [userController.isLogin.value] 변수를, "Obx()" 펑션 안에 넣어 주기만 하면 된다.
        title: Obx(() => Text("로그인 상태 ===> ${userController.isLogin.value}")),

        /// 2023.08.08 Added. 예를 들어, /controller/UserController.dart 파일에, isLogin 변수 값을 "false"로 강제 변경하는 메소드를 만들고,
        /// 아래 "+" 아이콘을 클리하면, 해당 forceChangeFalseInIsLogin() 메소드를 실행하게 해 본다.
        /// ***** 이미 "true"로 찍혀 있는 상태에서는 변경되지 않는다 *****
        /// 그럼 어떻게 처리해야 UI가 상태를 변경할 수 있을까? 그것은 간단하게도,
        /// 상기 [userController.isLogin.value] 변수를, "Obx()" 펑션 안에 넣어 주기만 하면 된다.
        actions: [IconButton(onPressed: () {
          userController.forceChangeFalseInIsLogin();
        }, icon: const Icon(Icons.add))],


      ),

      /// 2023.08.14 Added. 현재 홈 페이지에 뿌려진 리스트 데이터를 "Refresh"하는 기능 추가

      body: Obx(()=> RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          await postController.findAllPostController();
        },
        child: ListView.separated(
          // "구분 선"을 줄 때는, "builder" 보다 "separated"가 좋다.
          // itemCount: 30, // 3번 만큼, 아래 "ListTile()" 위젯이 뿌려진다. 수량이 많아지면, 자동으로 "스크롤"이 생긴다.
          itemCount: postController.postList.length, // 3번 만큼, 아래 "ListTile()" 위젯이 뿌려진다. 수량이 많아지면, 자동으로 "스크롤"이 생긴다.
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () async { // 상세 페이지로 이동.

                /// 2023.08.10 Added. HomePage()에서, 특정 게시글을 "클릭"할 때, findByIdPostController(id)를 실행하게 한다.
                /// 그러면, PostController.java 파일에서, "this.post.value"에, 특정 게시글 자료가 담길 것이므로,
                /// DetailPage.java 파일에서는, 뿌려지는 "Column" 위젯을, Obx(() => Column()) 이런식으로 감싸 주기만 하면 된다.
                ///
                /// 여기서 또 주의할 것은, "id" 값을 넘길 때, 반드시 값이 있는, null 아닌 값을 넘긴다는 의미로 "!"를 붙여서 넘긴다.

                await postController.findByIdPostController(postController.postList[index].id!);

                // 11강: GetX에서는,
                // 1> "Constructor.생성자"로 넘기는 방법이 있고,
                // 2> "arguments"를 통해서, 값을 넘길 수 있는, 2가지 방법이 있다.
                // 그런데, 2023.08.06 현재, "arguments" 방식은 안 되네...
                // Get.to(DetailPage(id: index, arguments: "arguments 방식도 있는데?"));
                // Get.to(DetailPage(id: index));
                Get.to(()=>DetailPage(id: postController.postList[index].id));
              },
              // leading: Text("1"),
              leading: Text("${postController.postList[index].id}"),
              // leading: Text("제목1"),
              // leading: Text("${postController.postList[index].title}"),
              // title: Text("제목1"),
              title: Text("${postController.postList[index].title}"),
              // title: Text("내용1"),
              // title: Text("${postController.postList[index].content}"),
              subtitle: Text("${postController.postList[index].content}"),
              // trailing: Text("1"),
              // trailing: Text("${postController.postList[index].id}"),
              trailing: const Icon(Icons.keyboard_arrow_right),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),),
    );
  }

  /// ===> LeftMenu.dart ===>
  /*
  Widget _navigation(BuildContext context) {
    UserController userController = Get.find();
    return Container(
      // drawer: "서랍장"
      // width: 250, // 폰 마다 Size가 다르므로, 이렇게 상수를 주면 위험(Overflow Error)하다. 메인 폴더에 "size.dart" 파일을 만들어서 관리한다.
      // width: getScreenWidth(context) * .6, // 이것도 따로 빼서, 다른 곳에서 사용할 수 있도록 한다.
      width: getDrawerWidth(context),
      height: double.infinity,
      color: Colors.white,

      // Left Menu 구성

      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // 너무 화면 위에 붙어 있어, "SafeArea" 위젯으로 감싸 주고, "Padding"도 적당히 16.0 준다.
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            // "Column"은 메인이 "CrossAxiasAlignment"
            children: [
              TextButton(
                onPressed: () {
                  Get.to(WritePage());
                },
                child: const Text(
                  "글 쓰기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              const Divider(), // 구분 선
              TextButton(
                onPressed: () {
                  /// 2023.08.14 Added. UserInfo.회원 정보 보기 화면으로 가서, 다시 뒤로 가기 아이콘(←)을 클릭했을 때,
                  /// LeftMenu() 화면으로 갈 것이 아니라, 바로 HomePage.홈 화면으로 가야된다.
                  /// 그러기 위해서는, "Stack" 메모리에서 가장 최상단에 올라와 있는 것(지금은 LeftMenu())을 .pop(제거)해 주면 된다.

                  Navigator.pop(context);
                  // scaffoldKey.currentState!.openEndDrawer();

                  Get.to(() => UserInfo());
                },
                child: const Text(
                  "회원 정보 보기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              const Divider(), // 구분 선
              TextButton(
                onPressed: () {
                  // 2023.08.08 Added. Login.로그인 페이지로 가기 전에,
                  // 반드시, 아래 내용을 먼저 초기화 해 주어야 한다.
                  // 1> 상태 관리 초기화: isLogin.value = false;
                  // 2> 토큰 초기화: jwtToken = null;
                  // 이를 위하여, 상단에 UserController userController = Get.find(); 선언을 해 주어야 한다.
                  // userController.isLogin.value = false;
                  // jwtToken = null;
                  // ===> 그런데,
                  // 여기서 이렇게 자질구레하게 처리하는 것 보다,
                  // UserController.dart 파일에서, 펑션 처리하고, 여기서는 그 펑션만 호출하는 것이 매우 깔끔하다 할 수 있겠다.

                  userController.logout();

                  Get.to(LoginPage());
                  // Get.to(LogoutPage());
                },
                child: const Text(
                  "로그아웃",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              const Divider(), // 구분 선
            ],
          ),
        ),
      ),
    );
  }
  */

}

