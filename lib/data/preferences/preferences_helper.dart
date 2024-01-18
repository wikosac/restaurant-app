import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const dailyReminder = 'DAILY_REMINDER';
  static const uidToken = 'UID_TOKEN';

  Future<bool> get isReminderActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyReminder) ?? false;
  }

  void setReminder(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyReminder, value);
  }

  Future<String?> get token async {
    final prefs = await sharedPreferences;
    return prefs.getString(uidToken);
  }

  void setToken(String token) async {
    final prefs = await sharedPreferences;
    prefs.setString(uidToken, token);
  }

  void deleteToken(String token) async {
    final prefs = await sharedPreferences;
    prefs.remove(uidToken);
  }
}