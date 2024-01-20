import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/provider/login_provider.dart';
import 'package:restaurant_app/data/provider/preferences_provider.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login_page';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: Material(
        color: lightColorScheme.primaryContainer,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/login.svg',
                  height: 300,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 32.0),
                      Consumer2<LoginProvider, PreferencesProvider>(
                        builder: (context, auth, pref, _) {
                          return ElevatedButton(
                            onPressed: () async {
                              String email = emailController.text;
                              String password = passwordController.text;
          
                              if (email.isNotEmpty || password.isNotEmpty) {
                                final user = await auth.signInWithEmailAndPassword(
                                    context, email, password);
                                if (user != null) {
                                  final credential = [
                                    user.email!,
                                    user.displayName ?? '',
                                    user.photoURL ?? ''
                                  ];
                                  pref.setCredential(credential);
                                }
                              } else {
                                var snackBar = const SnackBar(
                                  content: Text('Form tidak boleh kosong'),
                                  duration: Duration(seconds: 3),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                              ),
                            ),
                            child: const Text('Masuk'),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Atau masuk dengan:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 16),
                _buildGoogleButton(),
                const SizedBox(height: 32),
                InkWell(
                  onTap: () {
                    Navigation.intent(Navigation.routeName);
                  },
                  child: Text(
                    'Masuk sebagai tamu',
                    style: TextStyle(
                        color: lightColorScheme.primary,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleButton() {
    return Consumer2<LoginProvider, PreferencesProvider>(
      builder: (context, auth, pref, _) {
        return ElevatedButton(
          onPressed: () async {
            final user = await auth.signInWithGoogle(context);
            if (user != null) {
              final credential = [
                user.email!,
                user.displayName!,
                user.photoURL!
              ];
              pref.setCredential(credential);
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
                    const Text('Google'),
                  ],
                ),
        );
      },
    );
  }
}
