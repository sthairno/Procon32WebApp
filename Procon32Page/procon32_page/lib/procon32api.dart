import 'dart:async';
import 'dart:typed_data';

import 'package:openapi/openapi.dart' as api;
import 'package:dio/dio.dart';
import 'package:built_collection/src/list.dart';

class Procon32API {
  final _openapi = new api.Openapi();

  final _userStateChangesController = new StreamController<api.User?>();

  api.User? _user;

  String? _apiKey;

  Stream<api.User?> userStateChanges() => _userStateChangesController.stream;

  Future<void> _getApiKey(String jwtToken) async {
    if (_user == null) {
      return;
    }
    _apiKey = (await _openapi.getUserApi().apiUserApikeyGet()).data?.key;
    _openapi.setApiKey("APIKey", _apiKey!);
  }

  Future<api.User?> login(String jwtToken) async {
    // ユーザー取得
    _openapi.setApiKey("JWT", "Bearer $jwtToken");
    try {
      var result = await _openapi.getUserApi().apiUserGet();
      _user = result.data;
    } on DioError catch (e) {
      if ((e.response?.statusCode ?? 0) != 404) {
        _openapi.setApiKey("JWT", "");
        rethrow;
      }
      _user = null;
    }
    if (_user == null) {
      _openapi.setApiKey("JWT", "");
      return null;
    }

    // APIキーの取得
    _getApiKey(jwtToken);

    _userStateChangesController.sink.add(_user);
    return _user;
  }

  Future<api.User?> createUser(String jwtToken, String displayName) async {
    //　ユーザー作成リクエスト
    _openapi.setApiKey("JWT", "Bearer $jwtToken");
    var reqUser = new api.User((b) => b.displayName = displayName);
    try {
      var result = await _openapi.getUserApi().apiUserPost(user: reqUser);
      _user = result.data;
    } on DioError catch (e) {
      if (![409, 400].contains(e.response?.statusCode ?? 0)) {
        _openapi.setApiKey("JWT", "");
        rethrow;
      }
      _user = null;
    }
    if (_user == null) {
      _openapi.setApiKey("JWT", "");
      return null;
    }

    // APIキーの取得
    _getApiKey(jwtToken);

    _userStateChangesController.sink.add(_user);
    return _user;
  }

  void logout() {
    if (_user == null) {
      return;
    }
    _openapi.setApiKey("JWT", "");
    _openapi.setApiKey("APIKey", "");
    _user = null;

    _userStateChangesController.sink.add(null);
  }

  bool isLoggedIn() => _user != null;

  Future<bool> deleteUser() async {
    if (_user == null) {
      return false;
    }
    try {
      var result = await _openapi.getUserApi().apiUserDelete();
      if (result.statusCode == 204) {
        logout();
        return true;
      }
      return false;
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) {
        rethrow;
      }
      return false;
    }
  }

  api.User? getUser() => _user;

  Future<api.User?> getUserById(String id) async {
    try {
      var result = await _openapi.getUserApi().apiUserIdGet(id: id);
      return result.data;
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) {
        rethrow;
      }
      return null;
    }
  }

  Future<String?> updateApiKey() async {
    if (_user == null) {
      return null;
    }

    var result = await _openapi.getUserApi().apiUserApikeyUpdatePost();
    _apiKey = result.data?.key;
    _openapi.setApiKey("APIKey", _apiKey!);

    return _apiKey;
  }

  Future<bool> ping() async {
    try {
      var result = await _openapi.getPingApi().apiPingGet();
      return result.statusCode == 200;
    } on DioError {
      return false;
    }
  }

  Future<bool> pingWithAPIKey() async {
    try {
      var result = await _openapi.getPingApi().apiPingApikeyGet();
      return result.statusCode == 200;
    } on DioError {
      return false;
    }
  }

  Future<bool> pingWithJWT() async {
    try {
      var result = await _openapi.getPingApi().apiPingJwtGet();
      return result.statusCode == 200;
    } on DioError {
      return false;
    }
  }

  Future<List<api.Image>?> getImages() async {
    if (_user == null) {
      return null;
    }
    try {
      var result = await _openapi.getImagesApi().apiImagesGet();
      return result.data?.toList();
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) {
        rethrow;
      }
      return null;
    }
  }

  Future<api.Image?> getImageById(String id) async {
    try {
      var result = await _openapi.getImagesApi().apiImagesIdGet(id: id);
      return result.data;
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) {
        rethrow;
      }
      return null;
    }
  }

  Future<bool> deleteImage(api.Image image) async {
    if (_user == null) {
      return false;
    }
    try {
      var result =
          await _openapi.getImagesApi().apiImagesIdDelete(id: image.id!);
      return result.statusCode == 204;
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) {
        rethrow;
      }
      return false;
    }
  }

  Future<api.Image?> uploadImage(Uint8List imageFile) async {
    if (_user == null) {
      return null;
    }
    try {
      var result =
          await _openapi.getImagesApi().apiImagesUploadPost(file: imageFile);
      return result.data;
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) {
        rethrow;
      }
      return null;
    }
  }

  Future<List<api.Subject>?> getSubjects() async {
    try {
      var result = await _openapi.getSubjectsApi().apiSubjectsGet();
      return result.data!.toList();
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) {
        rethrow;
      }
      return null;
    }
  }

  Future<api.Subject?> getSubjectById(String id) async {
    try {
      var result = await _openapi.getSubjectsApi().apiSubjectsIdGet(id: id);
      return result.data;
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) {
        rethrow;
      }
      return null;
    }
  }

  Future<api.Subject?> createSubjectById(
      api.Image baseImage,
      String name,
      int maxSelectCount,
      int selectionCost,
      int swapCost,
      int peaceCountX,
      int peaceCountY,
      List<List<String>> indexes,
      List<List<api.PeaceRotate>> rotations) async {
    if (_user == null) {
      return null;
    }

    var reqSubject = new api.Subject((b) {
      b.baseImageId = baseImage.id;
      b.name = name;
      b.maxSelectCount = maxSelectCount;
      b.selectionCost = selectionCost;
      b.swapCost = swapCost;
      b.peaceCount.x = peaceCountX;
      b.peaceCount.y = peaceCountY;
      b.indexes.addAll(indexes.map((r) => ListBuilder<String>(r).build()));
      b.rotations.addAll(
          rotations.map((r) => ListBuilder<api.PeaceRotate>(r).build()));
    });
    try {
      var result =
          await _openapi.getSubjectsApi().apiSubjectsPost(subject: reqSubject);
      return result.data;
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) {
        rethrow;
      }
      return null;
    }
  }

  Future<bool> deleteSubject(api.Subject subject) async {
    if (_user == null) {
      return false;
    }
    try {
      var result =
          await _openapi.getSubjectsApi().apiSubjectsIdDelete(id: subject.id!);
      return result.statusCode == 204;
    } on DioError catch (e) {
      if (e.type != DioErrorType.response) {
        rethrow;
      }
      return false;
    }
  }
}
