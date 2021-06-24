# openapi.api.SubjectsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiSubjectsGet**](SubjectsApi.md#apisubjectsget) | **get** /api/Subjects | すべての課題を取得
[**apiSubjectsIdDelete**](SubjectsApi.md#apisubjectsiddelete) | **delete** /api/Subjects/{id} | 課題の削除
[**apiSubjectsIdGet**](SubjectsApi.md#apisubjectsidget) | **get** /api/Subjects/{id} | 課題情報の取得
[**apiSubjectsPost**](SubjectsApi.md#apisubjectspost) | **post** /api/Subjects | 課題の生成


# **apiSubjectsGet**
> BuiltList<Subject> apiSubjectsGet()

すべての課題を取得

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

var api_instance = new SubjectsApi();

try { 
    var result = api_instance.apiSubjectsGet();
    print(result);
} catch (e) {
    print('Exception when calling SubjectsApi->apiSubjectsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList<Subject>**](Subject.md)

### Authorization

[Header](../README.md#Header), [Query](../README.md#Query)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSubjectsIdDelete**
> apiSubjectsIdDelete(id)

課題の削除

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

var api_instance = new SubjectsApi();
var id = id_example; // String | 課題ID

try { 
    api_instance.apiSubjectsIdDelete(id);
} catch (e) {
    print('Exception when calling SubjectsApi->apiSubjectsIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| 課題ID | 

### Return type

void (empty response body)

### Authorization

[Header](../README.md#Header), [Query](../README.md#Query)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSubjectsIdGet**
> Subject apiSubjectsIdGet(id)

課題情報の取得

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

var api_instance = new SubjectsApi();
var id = id_example; // String | 課題ID

try { 
    var result = api_instance.apiSubjectsIdGet(id);
    print(result);
} catch (e) {
    print('Exception when calling SubjectsApi->apiSubjectsIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| 課題ID | 

### Return type

[**Subject**](Subject.md)

### Authorization

[Header](../README.md#Header), [Query](../README.md#Query)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSubjectsPost**
> Subject apiSubjectsPost(subject)

課題の生成

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

var api_instance = new SubjectsApi();
var subject = new Subject(); // Subject | 課題情報

try { 
    var result = api_instance.apiSubjectsPost(subject);
    print(result);
} catch (e) {
    print('Exception when calling SubjectsApi->apiSubjectsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **subject** | [**Subject**](Subject.md)| 課題情報 | [optional] 

### Return type

[**Subject**](Subject.md)

### Authorization

[Header](../README.md#Header), [Query](../README.md#Query)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

