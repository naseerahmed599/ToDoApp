import 'package:flutter/material.dart';
import 'package:todoapp/utils/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.lime[300],
      content: Container(
        height: 130,
        child: Column(
          children: [
            // get uesr input
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Add a New Task'),
            ),

            const SizedBox(
              height: 20,
            ),
            // button -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Save Button
                MyButton(
                  text: "Save",
                  onPressed: onSave,
                ),
                const SizedBox(
                  width: 8,
                ),
                // Cancel Button
                MyButton(
                  text: "Cancel",
                  onPressed: onCancel,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
