import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const dailyReminder = 'DAILY_REMINDER';

  Future<bool> get isReminderActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyReminder) ?? false;
  }

  void setReminder(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyReminder, value);
  }
}