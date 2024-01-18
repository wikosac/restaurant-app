import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
            SvgPicture.asset('assets/login.svg', height: 300,),
            const SizedBox(height: 48),
            _buildGoogleButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleButton() {
    return Consumer2<LoginProvider, PreferencesProvider>(
        builder: (context, auth, pref, _) {
      return ElevatedButton(
        onPressed: () async {
          final uid = await auth.signInWithGoogle(context);
          if (uid != null) {
            pref.setToken(uid);
          }
        },
        child: auth.isLoading
            ? const CircularProgressIndicator()
            : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/google.svg',
                  width: 28,
                  height: 28,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text('Masuk'),
              ],
            ),
      );
    });
  }
}
