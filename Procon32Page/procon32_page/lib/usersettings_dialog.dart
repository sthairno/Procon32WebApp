import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openapi/openapi.dart' as api;

import 'common.dart';

class UserSettingsDialog extends StatelessWidget {
  const UserSettingsDialog(
    this.user, {
    Key? key,
  }) : super(key: key);

  final api.User user;

  Widget _buildTitle(BuildContext context, String str) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          str,
          style: Theme.of(context).textTheme.headline6,
        ),
      );

  Widget _buildButton(BuildContext context, String str,
          {VoidCallback? onTap}) =>
      InkWell(
        child: ListTile(
          title: Text(str),
        ),
        onTap: onTap,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ユーザー設定")),
      body: ListView(
        children: [
          _buildTitle(context, "APIキー"),
          _buildButton(
            context,
            "クリップボードにコピー",
            onTap: () {
              Clipboard.setData(ClipboardData(text: procon32api.apiKey));
              showSimpleSnackbar(context, "Copied!");
            },
          ),
          _buildButton(
            context,
            "APIキーを更新",
            onTap: () async {
              if (await procon32api.updateApiKey() == null) {
                showSimpleSnackbar(context, "失敗しました");
              } else {
                showSimpleSnackbar(context, "APIキーを更新しました");
              }
            },
          ),
          _buildTitle(context, "ユーザー"),
          _buildButton(
            context,
            "ユーザーを削除",
            onTap: () async {
              var result = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("ユーザーの削除"),
                  content: Text("このユーザーを削除しますか？\nこの操作は取り消せません。"),
                  actions: [
                    SimpleDialogOption(
                      child: Text("はい"),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                    ),
                    SimpleDialogOption(
                      child: Text("いいえ"),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                    )
                  ],
                ),
              );
              if (result as bool) {
                if (await procon32api.deleteUser()) {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                } else {
                  showSimpleSnackbar(context, "削除に失敗しました");
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
