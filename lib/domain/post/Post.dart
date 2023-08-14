import 'package:intl/intl.dart';

import '../user/User.dart';

class Post {
  late final int? id;
  final String? title;
  final String? content;
  final User? user;
  final DateTime? created;
  final DateTime? updated;

  Post({
    this.id,
    this.title,
    this.content,
    this.user,
    this.created,
    this.updated,
  });

  // factory Post.fromJson(Map<String, dynamic> json) {
  //   return Post(
  //     id: json["id"],
  //     title: json["title"],
  //     content: json["content"],
  //     user: User.fromJson(json["user"]),
  //     created = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json['created']),
  //     updated = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json['updated']);
  //   );
  // }

  Post.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        content = json["content"],
        user = User.fromJson(json["user"]),
        created = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json['created']),
        updated = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(json['updated']);

}

      /// 2023.08.10 Conclusion. 여기 아래 구문은 "정상 작동" 됨.
      // created = DateFormat('yyyy-mm-dd').parse(json['created']),
      // updated = DateFormat('yyyy-mm-dd').parse(json['updated']);

      /// 2023.08.10 Conclusion. 여기 아래 구문은 "표시 없는" 치명적 에러로, ***** 특별히 조심해야 한다 ***** 중간에 "T" 문자 1개 빠짐.
      // created = DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['created']),
      // updated = DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['updated']);