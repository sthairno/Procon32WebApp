import 'dart:convert';
import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:procon32_page/procon32api.dart';
import 'package:openapi/openapi.dart' as api;

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

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Procon32API _procon32api = new Procon32API();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<api.Subject> _subjects = [];

  _HomePageState() {
    _procon32api.userStateChanges().listen((user) {
      if (user == null) {
        print("[procon32api] logout");
      } else {
        print("[procon32api] login");
      }
      setState(() {});
    });

    if (_auth.currentUser != null) {
      _loginToProcon32Api(_auth.currentUser!);
    }

    _auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        print("[firebase] logout");
        _procon32api.logout();
      } else {
        print("[firebase] login");
        await _loginToProcon32Api(user);
      }
    });
  }

  // Googleにサインイン
  // 参考: https://firebase.flutter.dev/docs/auth/social/
  Future<UserCredential> _signInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }

  Future<void> _loginToProcon32Api(User user) async {
    var apiUser = await _procon32api.login(await user.getIdToken());
    if (apiUser == null) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (builder) => CreateUserDialog(_procon32api));
    }
  }

  void updateSubjectList() async {
    var result = await _procon32api.getSubjects();
    setState(() {
      _subjects = result ?? [];
    });
  }

  @override
  void initState() {
    super.initState();

    updateSubjectList();
  }

  Widget _buildSubjectCard(api.Subject subject) => Stack(children: [
        Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
            ),
            padding: EdgeInsets.all(4.0),
            child: Center(
                child: Image.network(
                    "https://procon32.sthairno.dev${subject.thumbnailFilePath}",
                    fit: BoxFit.fitWidth))),
        Container(
            color: Colors.white,
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text("${subject.name}"),
              subtitle: Text("${subject.id}"),
            )),
      ]);

  @override
  Widget build(BuildContext context) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    var procon32apiUser = _procon32api.getUser();

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
                )));

    return Scaffold(
      appBar: AppBar(
        title: Text("Procon32競技練習サーバー"),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                bool nomal = await _procon32api.ping();
                bool jwt = await _procon32api.pingWithJWT();
                bool apikey = await _procon32api.pingWithAPIKey();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Ping: ${nomal ? "Success" : "Fail"}\nPing(JWT): ${jwt ? "Success" : "Fail"}\nPing(APIKey): ${apikey ? "Success" : "Fail"}")));
              },
              icon: const Icon(Icons.contactless)),
          IconButton(
              onPressed: () {
                updateSubjectList();
              },
              icon: const Icon(Icons.refresh)),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              child: procon32apiUser == null
                  ? OutlinedButton(
                      onPressed: () async {
                        _signInWithGoogle();
                      },
                      child: Text(
                        "ログイン",
                        style: TextStyle(color: Colors.white),
                      ))
                  : PopupMenuButton(
                      child: userIcon,
                      tooltip: procon32apiUser.displayName,
                      onSelected: (_) async {
                        await _auth.signOut();
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
                            )
                          ]))
        ],
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children:
            _subjects.map((subject) => _buildSubjectCard(subject)).toList(),
        staggeredTiles: _subjects
            .map((subject) => StaggeredTile.count(
                1, subject.peaceCount.y / subject.peaceCount.x))
            .toList(),
      ),
      floatingActionButton: _procon32api.isLoggedIn()
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (builder) => CreateSubjectDialog());
              },
              tooltip: "課題を作成",
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
