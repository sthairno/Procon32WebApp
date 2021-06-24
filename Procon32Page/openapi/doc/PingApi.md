# openapi.api.PingApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiPingApikeyGet**](PingApi.md#apipingapikeyget) | **get** /api/Ping/apikey | 
[**apiPingGet**](PingApi.md#apipingget) | **get** /api/Ping | 
[**apiPingJwtGet**](PingApi.md#apipingjwtget) | **get** /api/Ping/jwt | 


# **apiPingApikeyGet**
> apiPingApikeyGet()



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

var api_instance = new PingApi();

try { 
    api_instance.apiPingApikeyGet();
} catch (e) {
    print('Exception when calling PingApi->apiPingApikeyGet: $e\n');
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

# **apiPingGet**
> apiPingGet()



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

var api_instance = new PingApi();

try { 
    api_instance.apiPingGet();
} catch (e) {
    print('Exception when calling PingApi->apiPingGet: $e\n');
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

# **apiPingJwtGet**
> apiPingJwtGet()



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

var api_instance = new PingApi();

try { 
    api_instance.apiPingJwtGet();
} catch (e) {
    print('Exception when calling PingApi->apiPingJwtGet: $e\n');
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

