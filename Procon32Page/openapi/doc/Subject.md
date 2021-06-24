# openapi.model.Subject

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | 課題ID | [optional] 
**createdUserId** | **String** | 作成者ユーザーID | [optional] 
**createdDateTime** | [**DateTime**](DateTime.md) | 作成日 | [optional] 
**size** | [**Size**](Size.md) |  | [optional] 
**subjectFilePath** | **String** | 課題ファイルパス | [optional] 
**previewFilePath** | **String** | プレビュー画像パス | [optional] 
**thumbnailFilePath** | **String** | サムネイル画像パス | [optional] 
**baseImage** | [**Image**](Image.md) |  | [optional] 
**baseImageId** | **String** | 原画像ID | 
**name** | **String** | 表示名 | 
**maxSelectCount** | **int** | 最大選択回数 | 
**selectionCost** | **int** | 選択コスト | 
**swapCost** | **int** | 交換コスト | 
**peaceCount** | [**CountXY**](CountXY.md) |  | 
**indexes** | [**BuiltList<BuiltList<String>>**](BuiltList.md) | 各ピースの位置情報 | 
**rotations** | [**BuiltList<BuiltList<PeaceRotate>>**](BuiltList.md) | 各ピースの回転情報 | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


