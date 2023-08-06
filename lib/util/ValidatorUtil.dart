import 'package:validators/validators.dart';

Function doValidateUserName() { //
// Function validateUserName() { // 8강
  return (String? value) { // value: 사용자가 타이핑한 내용.
    // print(value);
    if (value!.isEmpty) {
      return "User Name cannot be empty";
    } else if (value.length < 4) {
      return "User Name must be at least 4 characters long";
    } else if (!isAlphanumeric(value)) {
      return "User Name must be alphabet or number";
    } else {
      return null;
    }
  };
}

Function doValidatePassword() {
  return (String? value) { // value: 사용자가 타이핑한 내용.
    // print(value);
    if (value!.isEmpty) {
      return "Password cannot be empty";
    } else if (value.length < 4) {
      return "Password must be at least 4 characters long";
    // } else if (!isAlpha(value)) {
    //   return "Password must be alphabet";
    } else {
      return null;
    }
  };
}

Function doValidateEmail() {
  return (String? value) {
    // value: 사용자가 타이핑한 내용.
    // print(value);
    if (value!.isEmpty) {
      return "Email cannot be empty";
    } else if (!isEmail(value)) {
      return "Email must be Email address";
    } else {
      return null;
    }
  };
}

Function doValidateTitle() {
  return (String? value) {
    // value: 사용자가 타이핑한 내용.
    // print(value);
    if (value!.isEmpty) {
      return "제목을 입력하시오!";}
    else if (value.length > 30) {
      return "제목은 30 글자를 초과할 수 없습니다!";
    } else {
      return null;
    }
  };
}

Function doValidateContent() {
  return (String? value) {
    // value: 사용자가 타이핑한 내용.
    // print(value);
    if (value!.isEmpty) {
      return "내용을 입력하시오!";}
    else if (value.length > 500) {
      return "내용은 500 글자를 초과할 수 없습니다!";
    } else {
      return null;
    }
  };
}