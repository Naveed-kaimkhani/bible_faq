import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontSizeController extends GetxController {
  var selectedFont = "Arial".obs;
  var fontSize = 16.0.obs;

  @override
  void onInit() async {
    super.onInit();
    await _loadFontSize();
  }

  Future<void> _loadFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fontSize.value = prefs.getDouble('fontSize') ?? 16.0;
    selectedFont.value = prefs.getString('selectedFont') ?? "Arial";
  }

  Future<void> setFont(String font) async {
    selectedFont.value = font;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedFont', font);
  }

  Future<void> setFontSize(double size) async {
    fontSize.value = size;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', size);
  }
}
