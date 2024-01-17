import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/provider/login_provider.dart';
import 'package:restaurant_app/data/provider/preferences_provider.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login_page';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightColorScheme.primaryContainer,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/restaurant.png', height: 100, width: 100),
            const SizedBox(height: 100),
            _buildGoogleButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleButton() {
    return Consumer2<LoginProvider, PreferencesProvider>(
        builder: (context, auth, pref, _) {
          return ElevatedButton.icon(
            onPressed: () async {
              final uid = await auth.signInWithGoogle(context);
              if (uid != null) {
                await pref.setToken(uid);
              }
              print(pref.token);
            },
            icon: const Icon(Icons.person),
            label: auth.isLoading
                ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                )
                : const Text('Sign in'),
          );
        }
    );
  }
}
