import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:procon32_page/procon32api.dart';

class CreateUserDialog extends StatefulWidget {
  CreateUserDialog(this.api);

  final Procon32API api;

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
              widget.api.createUser(
                  await FirebaseAuth.instance.currentUser!.getIdToken(),
                  _displayName);
              Navigator.pop(context);
            },
            child: Text("OK"))
      ],
    );
  }
}
