import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for ImagesApi
void main() {
  final instance = Openapi().getImagesApi();

  group(ImagesApi, () {
    // すべての画像を取得
    //
    //Future<BuiltList<Image>> apiImagesGet() async
    test('test apiImagesGet', () async {
      // TODO
    });

    // 画像の削除
    //
    //Future apiImagesIdDelete(String id) async
    test('test apiImagesIdDelete', () async {
      // TODO
    });

    // 画像情報の取得
    //
    //Future<Image> apiImagesIdGet(String id) async
    test('test apiImagesIdGet', () async {
      // TODO
    });

    // 画像のアップロード
    //
    //Future<Image> apiImagesUploadPost({ Uint8List file }) async
    test('test apiImagesUploadPost', () async {
      // TODO
    });

  });
}
