import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for SubjectsApi
void main() {
  final instance = Openapi().getSubjectsApi();

  group(SubjectsApi, () {
    // すべての課題を取得
    //
    //Future<BuiltList<Subject>> apiSubjectsGet() async
    test('test apiSubjectsGet', () async {
      // TODO
    });

    // 課題の削除
    //
    //Future apiSubjectsIdDelete(String id) async
    test('test apiSubjectsIdDelete', () async {
      // TODO
    });

    // 課題情報の取得
    //
    //Future<Subject> apiSubjectsIdGet(String id) async
    test('test apiSubjectsIdGet', () async {
      // TODO
    });

    // 課題の生成
    //
    //Future<Subject> apiSubjectsPost({ Subject subject }) async
    test('test apiSubjectsPost', () async {
      // TODO
    });

  });
}
