import 'package:flutter/material.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/utils/result_state.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getCredential();
    _getReminderPreferences();
  }

  bool _isReminderActive = false;

  bool get isReminderActive => _isReminderActive;

  List<String> _credential = [];

  List<String> get credential => _credential;

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

  void _getCredential() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await preferencesHelper.credential;

      if (result.isNotEmpty) {
        _credential = result;
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

  void setCredential(List<String> credential) {
    preferencesHelper.setCredential(credential);
    _getCredential();
  }

  void deleteCredential() {
    preferencesHelper.deleteCredential();
    _getCredential();
    _state = ResultState.noData;
    notifyListeners();
  }
}
