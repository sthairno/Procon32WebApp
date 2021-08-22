import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'procon32api.dart';
import 'usersettings_dialog.dart';

Procon32API _procon32api = Procon32API();

Procon32API get procon32api => _procon32api;

// Googleにサインイン
// 参考: https://firebase.flutter.dev/docs/auth/social/
Future<bool> _signInWithGoogle() async {
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  try {
    await FirebaseAuth.instance.signInWithPopup(googleProvider);
    return true;
  } on FirebaseAuthException {
    return false;
  }
}

AppBar buildAppBar(BuildContext context, {List<Widget>? actions = null}) {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  var procon32apiUser = procon32api.getUser();

  Widget userIcon = firebaseUser?.photoURL == null
      ? const Icon(Icons.account_circle)
      : Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(firebaseUser!.photoURL!),
            ),
          ),
        );

  var baseActions = <Widget>[
    Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: procon32apiUser == null
          ? OutlinedButton(
              onPressed: () async {
                await _signInWithGoogle();
              },
              child: Text(
                "ログイン",
                style: TextStyle(color: Colors.white),
              ),
            )
          : PopupMenuButton(
              child: userIcon,
              tooltip: procon32apiUser.displayName,
              onSelected: (String? item) async {
                switch (item) {
                  case "apikey":
                    Clipboard.setData(ClipboardData(text: procon32api.apiKey));
                    showSimpleSnackbar(context, "Copied!");
                    break;
                  case "settings":
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (BuildContext context) {
                          return UserSettingsDialog(procon32apiUser);
                        },
                      ),
                    );
                    break;
                  case "logout":
                    await FirebaseAuth.instance.signOut();
                    break;
                }
              },
              itemBuilder: (builder) => <PopupMenuEntry<String>>[
                PopupMenuItem(
                  enabled: false,
                  child: ListTile(
                    leading: userIcon,
                    title: Text(procon32apiUser.displayName),
                    subtitle: Text(procon32apiUser.userID!),
                  ),
                ),
                PopupMenuDivider(),
                PopupMenuItem(
                  value: "apikey",
                  child: ListTile(
                    title: Text("APIキーをコピー"),
                    trailing: const Icon(Icons.copy),
                  ),
                ),
                PopupMenuItem(
                  value: "settings",
                  child: ListTile(
                    title: Text("ユーザー設定"),
                    trailing: const Icon(Icons.settings),
                  ),
                ),
                PopupMenuItem(
                  value: "logout",
                  child: ListTile(
                    title: Text("ログアウト"),
                    trailing: const Icon(Icons.logout),
                  ),
                ),
              ],
            ),
    ),
  ];

  if (actions == null) {
    actions = [];
  }
  actions.addAll(baseActions);

  return AppBar(
    title: Text("Procon32競技練習サーバー"),
    actions: actions,
  );
}

Drawer buildDrawer(BuildContext context) {
  final routeName = ModalRoute.of(context)!.settings.name;
  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          child: Text("Procon32 競技練習サーバー"),
        ),
        ListTile(
          title: Text("課題一覧"),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {
            Navigator.pop(context);
            if (routeName != "/") {
              Navigator.of(context).pushReplacementNamed("/");
            }
          },
        ),
        ListTile(
          title: Text("回答"),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {
            Navigator.pop(context);
            if (routeName != "/submit") {
              Navigator.of(context).pushReplacementNamed("/submit");
            }
          },
        ),
        ListTile(
          title: Text("APIドキュメント"),
          trailing: const Icon(Icons.open_in_new),
          onTap: () {
            html.window.open('https://procon32.sthairno.dev/swagger/', '');
            Navigator.pop(context);
          },
        )
      ],
    ),
  );
}

void showSimpleSnackbar(BuildContext context, String text) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
