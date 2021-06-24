# openapi.api.UserApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiUserApikeyGet**](UserApi.md#apiuserapikeyget) | **get** /api/User/apikey | APIキーの取得
[**apiUserApikeyUpdatePost**](UserApi.md#apiuserapikeyupdatepost) | **post** /api/User/apikey/update | APIキーの更新
[**apiUserDelete**](UserApi.md#apiuserdelete) | **delete** /api/User | ユーザーを削除
[**apiUserGet**](UserApi.md#apiuserget) | **get** /api/User | 自身のユーザー情報を取得
[**apiUserIdGet**](UserApi.md#apiuseridget) | **get** /api/User/{id} | ユーザー情報の取得
[**apiUserPost**](UserApi.md#apiuserpost) | **post** /api/User | ユーザーを登録


# **apiUserApikeyGet**
> APIKey apiUserApikeyGet()

APIキーの取得

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

var api_instance = new UserApi();

try { 
    var result = api_instance.apiUserApikeyGet();
    print(result);
} catch (e) {
    print('Exception when calling UserApi->apiUserApikeyGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**APIKey**](APIKey.md)

### Authorization

[Header](../README.md#Header), [Query](../README.md#Query)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserApikeyUpdatePost**
> APIKey apiUserApikeyUpdatePost()

APIキーの更新

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

var api_instance = new UserApi();

try { 
    var result = api_instance.apiUserApikeyUpdatePost();
    print(result);
} catch (e) {
    print('Exception when calling UserApi->apiUserApikeyUpdatePost: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**APIKey**](APIKey.md)

### Authorization

[Header](../README.md#Header), [Query](../README.md#Query)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserDelete**
> apiUserDelete()

ユーザーを削除

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

var api_instance = new UserApi();

try { 
    api_instance.apiUserDelete();
} catch (e) {
    print('Exception when calling UserApi->apiUserDelete: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[Header](../README.md#Header), [Query](../README.md#Query)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserGet**
> User apiUserGet()

自身のユーザー情報を取得

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

var api_instance = new UserApi();

try { 
    var result = api_instance.apiUserGet();
    print(result);
} catch (e) {
    print('Exception when calling UserApi->apiUserGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**User**](User.md)

### Authorization

[Header](../README.md#Header), [Query](../README.md#Query)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserIdGet**
> User apiUserIdGet(id)

ユーザー情報の取得

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

var api_instance = new UserApi();
var id = id_example; // String | ユーザーID

try { 
    var result = api_instance.apiUserIdGet(id);
    print(result);
} catch (e) {
    print('Exception when calling UserApi->apiUserIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| ユーザーID | 

### Return type

[**User**](User.md)

### Authorization

[Header](../README.md#Header), [Query](../README.md#Query)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiUserPost**
> User apiUserPost(user)

ユーザーを登録

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

var api_instance = new UserApi();
var user = new User(); // User | 

try { 
    var result = api_instance.apiUserPost(user);
    print(result);
} catch (e) {
    print('Exception when calling UserApi->apiUserPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **user** | [**User**](User.md)|  | [optional] 

### Return type

[**User**](User.md)

### Authorization

[Header](../README.md#Header), [Query](../README.md#Query)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

