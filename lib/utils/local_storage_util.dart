import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageUtil {
  static const String _lastPromptDateKey = 'lastPromptDate';

  static Future<void> saveLastPromptDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastPromptDateKey, date.toIso8601String());
  }

  static Future<DateTime?> getLastPromptDate() async {
    final prefs = await SharedPreferences.getInstance();
    final dateString = prefs.getString(_lastPromptDateKey);
    if (dateString != null) {
      return DateTime.parse(dateString);
    }
    return null;
  }

  static Future<bool> hasLastPromptDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_lastPromptDateKey);
  }
}
