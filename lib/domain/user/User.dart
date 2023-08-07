import 'dart:convert';

import 'package:intl/intl.dart';

class User {
  final int? id;
  final String? username;
  // final String? password;
  final String? email;
  final DateTime? updated;
  final DateTime? created;

  User({
    this.id,
    this.username,
    this.email,
    this.updated,
    this.created,
  });

  // 통신을 위해서 JSON 처럼 생긴 문자열.

  // 이름이 있는 생성자.
  User.fromJson(Map<String, dynamic> json)
  : id = json['id'],
    username = json['username'],
    email = json['email'],
    updated = DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['updated']),
    created = DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['created']);

}
