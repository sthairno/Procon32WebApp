import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:openapi/openapi.dart' as api;

import 'createsubject_dialog.dart';
import 'common.dart';
import 'subjectdetails_dialog.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<api.Subject> _subjects = [];

  void _updateSubjectList() async {
    var result = await procon32api.getSubjects();
    setState(() {
      _subjects = result ?? [];
    });
  }

  @override
  void initState() {
    super.initState();

    _updateSubjectList();
  }

  Widget _buildSubjectCard(api.Subject subject) => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return SubjectDetailsDialog(subject);
              },
            ),
          );
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
              ),
              padding: EdgeInsets.all(4.0),
              child: Center(
                child: Image.network(
                  "https://procon32.sthairno.dev${subject.thumbnailFilePath}",
                  width: double.maxFinite,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black45,
                child: ListTile(
                  title: Text(
                    "${subject.name}",
                    style: TextStyle(color: Colors.grey.shade100),
                  ),
                  subtitle: Text(
                    "${subject.id}",
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                  trailing: subject.createdUserId == _auth.currentUser?.uid
                      ? IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey.shade100,
                          ),
                          onPressed: () async {
                            var result = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("課題の削除"),
                                content: Text(
                                    "課題(ID:${subject.id})を削除しますか？\nこの操作は取り消せません。"),
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
                              await procon32api.deleteSubject(subject);
                              _updateSubjectList();
                            }
                          },
                        )
                      : null,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _updateSubjectList();
            },
          ),
        ],
      ),
      drawer: buildDrawer(context),
      body: StaggeredGridView.extent(
        maxCrossAxisExtent: 400,
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
      floatingActionButton: procon32api.isLoggedIn()
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (BuildContext context) {
                      return CreateSubjectDialog(client: procon32api);
                    },
                  ),
                );
              },
              tooltip: "課題を作成",
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
