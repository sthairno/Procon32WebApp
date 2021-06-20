import 'dart:convert';
import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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

class Subject {
  final String id;
  final String name;
  final String subjectFilePath;
  final String previewFilePath;
  final String thumbnailFilePath;
  final int peaceCountX;
  final int peaceCountY;

  Subject(this.id, this.name, this.subjectFilePath, this.previewFilePath,
      this.thumbnailFilePath, this.peaceCountX, this.peaceCountY);
}

class _HomePageState extends State<HomePage> {
  final subjectsUri = Uri.http("localhost:5032", "api/subjects");

  List<Subject> _subjects = [];

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> ping() async {
    var result = await http.get(Uri.http("localhost:5032", "ping"));
    return result.statusCode == 200;
  }

  Future<bool> pingWithJWT() async {
    var result = await http.get(Uri.http("localhost:5032", "ping/jwt"),
        headers: {
          "Authorization": "Bearer ${await _auth.currentUser?.getIdToken()}"
        });
    return result.statusCode == 200;
  }

  void updateSubjectList() async {
    var result = await http.get(subjectsUri);
    if (result.statusCode != 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result.statusCode.toString())));
      print(result);
      return;
    }
    var body = (json.decode(result.body) as List<dynamic>)
        .cast<Map<String, dynamic>>();
    setState(() {
      _subjects = body
          .map((map) => Subject(
              map["id"],
              map["name"],
              map["subjectFilePath"],
              map["previewFilePath"],
              map["thumbnailFilePath"],
              map["peaceCount"]["x"],
              map["peaceCount"]["y"]))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) async {
      print("user: " + user.toString());
      if (user != null) {
        print("token: " + await user.getIdToken());
      }
    });
    updateSubjectList();
  }

  Widget _buildSubjectCard(Subject subject) => Stack(children: [
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
    var user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Procon32 競技練習サーバー"),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                bool nomal = await ping();
                bool jwt = await pingWithJWT();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Ping: ${nomal ? "Success" : "Fail"}\nPing(JWT): ${jwt ? "Success" : "Fail"}")));
              },
              icon: const Icon(Icons.contactless)),
          IconButton(
              onPressed: () {
                updateSubjectList();
              },
              icon: const Icon(Icons.refresh)),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
              child: user == null
                  ? OutlinedButton(
                      onPressed: () async {
                        try {
                          await _auth.signInAnonymously();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("サインインしました")));
                          setState(() {});
                        } on FirebaseAuthException {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("サインインに失敗しました")));
                        }
                      },
                      child: Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white),
                      ))
                  : IconButton(
                      onPressed: () async {
                        try {
                          await _auth.signOut();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("サインアウトしました")));
                          setState(() {});
                        } on FirebaseAuthException {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("サインアウトに失敗しました")));
                        }
                      },
                      icon: user.photoURL == null
                          ? const Icon(Icons.account_circle)
                          : Image.network(user.photoURL!),
                      color: Colors.white,
                    ))
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
                1, subject.peaceCountY / subject.peaceCountX))
            .toList(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // )
    );
  }
}
