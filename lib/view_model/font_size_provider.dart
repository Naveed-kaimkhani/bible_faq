import 'package:get/get.dart';

class FontSizeController extends GetxController {
  var selectedFont = "Arial".obs;
  var fontSize = 16.0.obs;

  void setFont(String font) {
    selectedFont.value = font;
  }

  void setFontSize(double size) {
    fontSize.value = size;
  }
}
