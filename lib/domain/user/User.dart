import 'package:intl/intl.dart';

class User {
  final int? id;
  final String? username;
  final String? email;
  final DateTime? created;
  final DateTime? updated;

  User({
    this.id,
    this.username,
    this.email,
    this.created,
    this.updated,
  });

  // 통신을 위해서 JSON 처럼 생긴 문자열.

  // 이름이 있는 생성자.
  User.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      username = json['username'],
      email = json['email'],
      created = DateFormat('yyyy-mm-ddTHH:mm:ss').parse(json['created']),
      updated = DateFormat('yyyy-mm-ddTHH:mm:ss').parse(json['updated']);
}

      /// 2023.08.10 Conclusion. 여기 아래 구문은 "정상 작동" 됨.
      // created = DateFormat('yyyy-mm-dd').parse(json['created']),
      // updated = DateFormat('yyyy-mm-dd').parse(json['updated']);

      /// 2023.08.10 Conclusion. 여기 아래 구문은 "표시 없는" 치명적 에러로, ***** 특별히 조심해야 한다 ***** 중간에 "T" 문자 1개 빠짐.
      // created = DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['created']),
      // updated = DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['updated']);
