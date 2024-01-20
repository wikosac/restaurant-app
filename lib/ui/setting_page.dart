import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/provider/login_provider.dart';
import 'package:restaurant_app/data/provider/preferences_provider.dart';
import 'package:restaurant_app/data/provider/scheduling_provider.dart';
import 'package:restaurant_app/ui/favorite_page.dart';

import 'login_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Pengaturan',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Consumer<PreferencesProvider>(
              builder: (context, pref, _) {
                final user = pref.credential;
                final email =
                    (user.isNotEmpty) ? user[0] : 'wesibrani@gmail.com';
                final name = (user.isNotEmpty && user[1].isNotEmpty)
                    ? user[1]
                    : 'Dwiko Indrawansyah';
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(84.0),
                      child: (user.isEmpty || user[2].isEmpty)
                          ? Image.asset(
                              'assets/pass.jpg',
                              height: 72,
                              width: 72,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              user[2],
                              height: 72,
                              width: 72,
                            ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    SizedBox(
                      height: 72,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                          Text(
                            email,
                            style: const TextStyle(fontSize: 12.0),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 36,
            ),
            ListTile(
              title: const Text('Rekomendasi Restoran'),
              trailing: Consumer2<PreferencesProvider, SchedulingProvider>(
                builder: (context, pref, scheduled, _) {
                  return Switch.adaptive(
                    value: pref.isReminderActive,
                    onChanged: (value) async {
                      if (Platform.isIOS) {
                        var snackBar = const SnackBar(
                          content: Text('Fitur ini segera hadir'),
                          duration: Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        scheduled.scheduledRestaurant(value);
                        pref.enableReminder(value);
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, FavoritePage.routeName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      const Text(
                        'Favoritku',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            ElevatedButton.icon(
              onPressed: () => _showLogoutConfirmationDialog(context),
              label: const Text('Keluar'),
              icon: const Icon(Icons.logout),
              style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Keluar'),
          content: const Text('Apa kamu yakin?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Batal'),
            ),
            Consumer2<LoginProvider, PreferencesProvider>(
              builder: (context, auth, pref, _) {
                return TextButton(
                  onPressed: () {
                    auth.signOut();
                    pref.deleteCredential();
                    Navigation.intent(LoginPage.routeName);
                  },
                  child: const Text('Keluar'),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
