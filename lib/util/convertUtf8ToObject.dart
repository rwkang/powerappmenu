import 'dart:convert';

dynamic convertUtf8ToObject(dynamic body) {

  // print("/util/convertUtf8ToObject.dart/responseBody.body: ${body}");
  // print("/util/convertUtf8ToObject.dart/responseBody.body.runtimeType: ${body.runtimeType}"); /// _Map<String, dynamic>
  // print("000==================================/util/convertUtf8ToObject.dart/");

  String responseBody = jsonEncode(body); // json 데이터로 변경
  // print("/util/convertUtf8ToObject.dart/responseBody.jsonEncode(body): ${responseBody}");
  // print("/util/convertUtf8ToObject.dart/responseBody.jsonEncode(body).runtimeType: ${responseBody.runtimeType}"); /// String
  // print("111==================================/util/convertUtf8ToObject.dart/");

  // var bytes = responseBody.codeUnits;
  // print("/util/convertUtf8ToObject.dart/responseBody.bytes: ${bytes}");
  // print("/util/convertUtf8ToObject.dart/responseBody.bytes.runtimeType: ${bytes.runtimeType}"); /// CodeUnits
  // print("222==================================/util/convertUtf8ToObject.dart/");

  try {
    dynamic convertBody = jsonDecode(utf8.decode(responseBody.codeUnits));
    // print("/util/convertUtf8ToObject.dart/responseBody.convertBody: ${convertBody}");
    // print("/util/convertUtf8ToObject.dart/responseBody.convertBody.runtimeType: ${convertBody.runtimeType}"); /// _Map<String, dynamic>
    // print("333==================================/util/convertUtf8ToObject.dart/");
    return convertBody;
  } catch (jsonDecodeError) {
    print("/util/convertUtf8ToObject.dart/==================> convert Error: ${jsonDecodeError.toString()}");
    return jsonDecodeError.toString();
  }

  // return body;

}

// String utf8convert(String text) {
//   var bytes = text.codeUnits;
//
//   String decodedCode = utf8.decode(bytes, allowMalformed: true);
//   if (decodedCode.contains("�")) {
//     return text;
//   }
//   return decodedCode;
// }
