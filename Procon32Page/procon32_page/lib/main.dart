import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Procon32 競技練習サーバー',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Noto Sans JP",
        ),
        home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                  body: Center(
                child: Text(snapshot.error.toString()),
              ));
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return HomePage();
            }

            return Scaffold();
          },
        ));
  }
}
