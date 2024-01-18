import 'package:flutter/material.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/utils/result_state.dart';

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

  late ResultState _state;

  ResultState get state => _state;

  void _getReminderPreferences() async {
    _isReminderActive = await preferencesHelper.isReminderActive;
    notifyListeners();
  }

  void enableReminder(bool value) {
    preferencesHelper.setReminder(value);
    _getReminderPreferences();
  }

  void _getToken() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await preferencesHelper.token;
      print(result);

      if (result != '') {
        _token = result;
        _state = ResultState.hasData;
        notifyListeners();
      } else {
        _state = ResultState.noData;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _state = ResultState.error;
      notifyListeners();
    }
  }

  void setToken(String uid) {
    preferencesHelper.setToken(uid);
    _getToken();
  }

  void deleteToken(String uid) {
    preferencesHelper.deleteToken(uid);
    _getToken();
    _state = ResultState.noData;
    notifyListeners();
  }
}
