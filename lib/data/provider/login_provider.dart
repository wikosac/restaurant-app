import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/auth_service.dart';

class LoginProvider extends ChangeNotifier {

  final AuthService authService = AuthService();

  User? currentUser;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      _setLoading(true);
      final User? user = await authService.signInWithGoogle();
      if (user != null) {
        currentUser = user;
        print('Signed in with Google: $user');
        Navigation.intent(Navigation.routeName);
        return user;
      } else {
        print('Google Sign-In failed');
      }
    } finally {
      _setLoading(false);
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(BuildContext context, String email, String password) async {
    try {
      _setLoading(true);
      final User? user = await authService.signInWithEmailAndPassword(email, password);
      if (user != null) {
        currentUser = user;
        print('Signed in with email: $user');
        Navigation.intent(Navigation.routeName);
        return user;
      } else {
        print('Email Sign-In failed');
      }
    } finally {
      _setLoading(false);
    }
    return null;
  }

  Future<void> signOut() async {
    await authService.signOut();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
