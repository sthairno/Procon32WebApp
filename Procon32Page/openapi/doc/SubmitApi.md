# openapi.api.SubmitApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiSubmitPost**](SubmitApi.md#apisubmitpost) | **post** /api/Submit | 回答の検証


# **apiSubmitPost**
> apiSubmitPost(subjectId, body)

回答の検証

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

var api_instance = new SubmitApi();
var subjectId = subjectId_example; // String | 課題ID
var body = new String(); // String | 回答データ

try { 
    api_instance.apiSubmitPost(subjectId, body);
} catch (e) {
    print('Exception when calling SubmitApi->apiSubmitPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **subjectId** | **String**| 課題ID | 
 **body** | **String**| 回答データ | [optional] 

### Return type

void (empty response body)

### Authorization

[Header](../README.md#Header), [Query](../README.md#Query)

### HTTP request headers

 - **Content-Type**: text/plain
 - **Accept**: text/plain

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

