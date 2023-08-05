
import 'package:flutter/cupertino.dart';

// double screenWidth = MediaQuery.of(context).size.width; // 이걸 아래와 같이 펑션으로 처리한다. ∵) context 때문에.

// Width.넓이
double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

// Height.높이
double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

// drawer width
double getDrawerWidth(BuildContext context) {
  return MediaQuery.of(context).size.width * .6;
}