import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:procon32_page/procon32api.dart';
import 'package:openapi/openapi.dart' as api;

import 'createsubject_dialog.dart';
import 'createuser_dialog.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

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
  Future<bool> _signInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    try {
      await _auth.signInWithPopup(googleProvider);
      return true;
    } on FirebaseAuthException {
      return false;
    }
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

  void _updateSubjectList() async {
    var result = await _procon32api.getSubjects();
    setState(() {
      _subjects = result ?? [];
    });
  }

  @override
  void initState() {
    super.initState();

    _updateSubjectList();
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
              onPressed: () {
                _updateSubjectList();
              },
              icon: const Icon(Icons.refresh)),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (BuildContext context) {
                        return CreateSubjectDialog(client: _procon32api);
                      },
                    ));
              },
              tooltip: "課題を作成",
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
