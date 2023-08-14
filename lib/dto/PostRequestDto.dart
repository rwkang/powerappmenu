class PostRequestDto {
  String? title;
  String? content;

  PostRequestDto({
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
  };

}
