/// 2023.08.08 Creared. 모든 Response.응답에 대한 처리를 위해,
/// Dto 클래스를 1개 만드는데, 그 형식이,
/// 1. code: 정상 응답: 1, 잘못된 응답: -1
/// 2. message: "seccess" or "error"
/// 3. data: dynamically generated: 각각의 응답 data 형식이 다르다. String, List, Json, ..., etc
///

class ResponseDto {

  final int? code;
  final String? message;
  final dynamic data;

  ResponseDto({
    this.code,
    this.message,
    this.data,
  });

  // 통신을 위해서 JSON 처럼 생긴 문자열.

  // 이름이 있는 생성자.
  ResponseDto.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        message = json['msg'],
        data = json['data'];

}