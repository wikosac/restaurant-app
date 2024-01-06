import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Pengaturan',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(84.0),
              child: Image.asset(
                'assets/pass.jpg',
                fit: BoxFit.cover,
                width: 72,
                height: 72,
              ),
            ),
            const SizedBox(width: 16.0,),
            const SizedBox(
              height: 72,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dwiko Indrawansyah",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  Text("wesibrani@gmail.com", style: TextStyle(fontSize: 12.0),)
                ]
              ),
            ),
          ]
        ),
      ),
    );
  }
}
