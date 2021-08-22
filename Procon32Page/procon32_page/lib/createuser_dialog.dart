import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:procon32_page/common.dart';

class CreateUserDialog extends StatefulWidget {
  CreateUserDialog();

  @override
  _CreateUserDialogState createState() => _CreateUserDialogState();
}

class _CreateUserDialogState extends State<CreateUserDialog> {
  String _displayName = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("ユーザーを作成"),
      content: TextField(
        decoration: new InputDecoration(labelText: "ユーザー名"),
        onChanged: (text) {
          setState(() {
            _displayName = text;
          });
        },
      ),
      actions: [
        TextButton(
            onPressed: () async {
              var result = await procon32api.createUser(
                  await FirebaseAuth.instance.currentUser!.getIdToken(),
                  _displayName);
              if (result == null) {
                FirebaseAuth.instance.signOut();
                showSimpleSnackbar(context, "ユーザーの作成に失敗しました");
              }
              Navigator.pop(context);
            },
            child: Text("OK"))
      ],
    );
  }
}
