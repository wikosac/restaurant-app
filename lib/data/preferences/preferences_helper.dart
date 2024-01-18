import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const dailyReminder = 'DAILY_REMINDER';
  static const credentialKey = 'CREDENTIAL_KEY';

  Future<bool> get isReminderActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyReminder) ?? false;
  }

  void setReminder(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyReminder, value);
  }

  Future<List<String>> get credential async {
    final prefs = await sharedPreferences;
    return prefs.getStringList(credentialKey) ?? [];
  }

  void setCredential(List<String> credential) async {
    final prefs = await sharedPreferences;
    prefs.setStringList(credentialKey, credential);
  }

  void deleteCredential() async {
    final prefs = await sharedPreferences;
    prefs.remove(credentialKey);
  }
}