import 'package:flutter/material.dart';

class CreateSubjectDialog extends StatefulWidget {
  const CreateSubjectDialog({Key? key}) : super(key: key);

  @override
  _CreateSubjectDialogState createState() => _CreateSubjectDialogState();
}

class _CreateSubjectDialogState extends State<CreateSubjectDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: Text("課題を作成"), actions: [
      TextButton(
        child: Text("キャンセル"),
        onPressed: () => Navigator.pop(context),
      ),
      TextButton(
        child: Text("作成"),
        onPressed: () {},
      ),
    ]);
  }
}
