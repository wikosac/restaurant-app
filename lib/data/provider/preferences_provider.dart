import 'package:flutter/material.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getToken();
    _getReminderPreferences();
  }

  bool _isReminderActive = false;

  bool get isReminderActive => _isReminderActive;

  String _token = '';

  String get token => _token;

  void _getReminderPreferences() async {
    _isReminderActive = await preferencesHelper.isReminderActive;
    notifyListeners();
  }

  void enableReminder(bool value) {
    preferencesHelper.setReminder(value);
    _getReminderPreferences();
  }

  void _getToken() async {
    final uid = await preferencesHelper.token;
    if (uid != null) _token = uid;
    notifyListeners();
  }

  void setToken(String uid) {
    preferencesHelper.setToken(uid);
    _getToken();
  }

  void deleteToken(String uid) {
    preferencesHelper.deleteToken(uid);
    _getToken();
  }
}
