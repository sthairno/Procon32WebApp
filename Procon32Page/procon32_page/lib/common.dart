import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'procon32api.dart';

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
              onSelected: (_) async {
                await FirebaseAuth.instance.signOut();
              },
              itemBuilder: (builder) => <PopupMenuEntry>[
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
                  value: 0,
                  child: Text("ログアウト"),
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
