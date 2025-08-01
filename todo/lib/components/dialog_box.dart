import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSaved;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onSaved,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text("Add new task", style: TextStyle(color: Colors.indigo)),
      //user input here
      content: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Task name",
        ),
        controller: controller,
      ),
      actions: [
        TextButton(onPressed: onCancel, child: Text('Cancel')),
        ElevatedButton(
          onPressed: onSaved,
          child: Text('Save'),
        ),
      ],
    );
  }
}
