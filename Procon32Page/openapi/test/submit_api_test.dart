import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for SubmitApi
void main() {
  final instance = Openapi().getSubmitApi();

  group(SubmitApi, () {
    // 回答の検証
    //
    //Future apiSubmitPost(String subjectId, { String body }) async
    test('test apiSubmitPost', () async {
      // TODO
    });

  });
}
