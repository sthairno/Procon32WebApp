import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'submitpage.dart';
import 'common.dart';
import 'createuser_dialog.dart';
import 'homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Procon32App());
}

class Procon32App extends StatefulWidget {
  @override
  _Procon32AppState createState() => _Procon32AppState();
}

class _Procon32AppState extends State<Procon32App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  bool _isReady = false;

  Widget _buildFeatureBuilder(Widget child) => FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Container(),
            );
          }
          if (snapshot.connectionState != ConnectionState.done) {
            if (_isReady == false) {
              procon32api.userStateChanges().listen((user) {
                if (user == null) {
                  print("[procon32api] logout");
                } else {
                  print("[procon32api] login");
                }
                setState(() {});
              });

              if (FirebaseAuth.instance.currentUser != null) {
                _loginToProcon32Api(FirebaseAuth.instance.currentUser!);
              }

              FirebaseAuth.instance
                  .authStateChanges()
                  .listen((User? user) async {
                if (user == null) {
                  print("[firebase] logout");
                  procon32api.logout();
                } else {
                  print("[firebase] login");
                  await _loginToProcon32Api(user);
                }
              });
            }
            _isReady = true;
            return Scaffold(
              body: Container(),
            );
          }
          return child;
        },
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Procon32 競技練習サーバー',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Noto Sans JP",
      ),
      routes: <String, WidgetBuilder>{
        "/": (context) => _buildFeatureBuilder(HomePage()),
        "/submit": (context) => _buildFeatureBuilder(SubmitPage()),
      },
    );
  }

  Future<void> _loginToProcon32Api(User user) async {
    var apiUser = await procon32api.login(await user.getIdToken());
    if (apiUser == null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (builder) => CreateUserDialog(procon32api),
      );
    }
  }
}
