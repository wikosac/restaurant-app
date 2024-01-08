import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';

void showBottomSheetDialog(BuildContext context, void Function(String text) onSubmit) {
  final TextEditingController controller = TextEditingController();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Kasih ulasan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Harganya terjangkau',
                  hintStyle:
                      const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: lightColorScheme.primary,
                    fixedSize: Size.fromWidth(MediaQuery.of(context).size.width)),
                child: const Text(
                  'Kirim',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  onSubmit(controller.text);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}