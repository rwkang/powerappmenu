import 'package:intl/intl.dart';

import '../user/User.dart';

class Post {
  final int? id;
  final String? title;
  final String? content;
  final User? user;
  final DateTime? updated;
  final DateTime? created;

  Post({
    this.id,
    this.title,
    this.content,
    this.user,
    this.updated,
    this.created,
  });

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        user = User.fromJson(json['user']),
        updated = DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['updated']),
        created = DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['created']);

}
