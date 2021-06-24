import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for UserApi
void main() {
  final instance = Openapi().getUserApi();

  group(UserApi, () {
    // APIキーの取得
    //
    //Future<APIKey> apiUserApikeyGet() async
    test('test apiUserApikeyGet', () async {
      // TODO
    });

    // APIキーの更新
    //
    //Future<APIKey> apiUserApikeyUpdatePost() async
    test('test apiUserApikeyUpdatePost', () async {
      // TODO
    });

    // ユーザーを削除
    //
    //Future apiUserDelete() async
    test('test apiUserDelete', () async {
      // TODO
    });

    // 自身のユーザー情報を取得
    //
    //Future<User> apiUserGet() async
    test('test apiUserGet', () async {
      // TODO
    });

    // ユーザー情報の取得
    //
    //Future<User> apiUserIdGet(String id) async
    test('test apiUserIdGet', () async {
      // TODO
    });

    // ユーザーを登録
    //
    //Future<User> apiUserPost({ User user }) async
    test('test apiUserPost', () async {
      // TODO
    });

  });
}
