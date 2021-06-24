# openapi.api.ImagesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiImagesGet**](ImagesApi.md#apiimagesget) | **get** /api/Images | すべての画像を取得
[**apiImagesIdDelete**](ImagesApi.md#apiimagesiddelete) | **delete** /api/Images/{id} | 画像の削除
[**apiImagesIdGet**](ImagesApi.md#apiimagesidget) | **get** /api/Images/{id} | 画像情報の取得
[**apiImagesUploadPost**](ImagesApi.md#apiimagesuploadpost) | **post** /api/Images/upload | 画像のアップロード


# **apiImagesGet**
> BuiltList<Image> apiImagesGet()

すべての画像を取得

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Header
//defaultApiClient.getAuthentication<ApiKeyAuth>('Header').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Header').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: Query
//defaultApiClient.getAuthentication<ApiKeyAuth>('Query').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Query').apiKeyPrefix = 'Bearer';

var api_instance = new ImagesApi();

try { 
    var result = api_instance.apiImagesGet();
    print(result);
} catch (e) {
    print('Exception when calling ImagesApi->apiImagesGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList<Image>**](Image.md)

### Authorization

[Header](../README.md#Header), [Query](../README.md#Query)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiImagesIdDelete**
> apiImagesIdDelete(id)

画像の削除

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Header
//defaultApiClient.getAuthentication<ApiKeyAuth>('Header').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Header').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: Query
//defaultApiClient.getAuthentication<ApiKeyAuth>('Query').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Query').apiKeyPrefix = 'Bearer';

var api_instance = new ImagesApi();
var id = id_example; // String | 画像ID

try { 
    api_instance.apiImagesIdDelete(id);
} catch (e) {
    print('Exception when calling ImagesApi->apiImagesIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| 画像ID | 

### Return type

void (empty response body)

### Authorization

[Header](../README.md#Header), [Query](../README.md#Query)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiImagesIdGet**
> Image apiImagesIdGet(id)

画像情報の取得

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Header
//defaultApiClient.getAuthentication<ApiKeyAuth>('Header').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Header').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: Query
//defaultApiClient.getAuthentication<ApiKeyAuth>('Query').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Query').apiKeyPrefix = 'Bearer';

var api_instance = new ImagesApi();
var id = id_example; // String | 画像ID

try { 
    var result = api_instance.apiImagesIdGet(id);
    print(result);
} catch (e) {
    print('Exception when calling ImagesApi->apiImagesIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| 画像ID | 

### Return type

[**Image**](Image.md)

### Authorization

[Header](../README.md#Header), [Query](../README.md#Query)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiImagesUploadPost**
> Image apiImagesUploadPost(file)

画像のアップロード

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: Header
//defaultApiClient.getAuthentication<ApiKeyAuth>('Header').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Header').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: Query
//defaultApiClient.getAuthentication<ApiKeyAuth>('Query').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Query').apiKeyPrefix = 'Bearer';

var api_instance = new ImagesApi();
var file = BINARY_DATA_HERE; // Uint8List | 画像ファイル

try { 
    var result = api_instance.apiImagesUploadPost(file);
    print(result);
} catch (e) {
    print('Exception when calling ImagesApi->apiImagesUploadPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **Uint8List**| 画像ファイル | [optional] 

### Return type

[**Image**](Image.md)

### Authorization

[Header](../README.md#Header), [Query](../README.md#Query)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

