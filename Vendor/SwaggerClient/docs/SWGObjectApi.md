# SWGObjectApi

All URIs are relative to *http://api.stylelens.io*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getObjectsByImageFile**](SWGObjectApi.md#getobjectsbyimagefile) | **POST** /objects | Query to search objects and products
[**getObjectsByProductId**](SWGObjectApi.md#getobjectsbyproductid) | **GET** /objects/products/{productId} | Query to search multiple objects


# **getObjectsByImageFile**
```objc
-(NSURLSessionTask*) getObjectsByImageFileWithFile: (NSURL*) file
        completionHandler: (void (^)(SWGGetObjectsResponse* output, NSError* error)) handler;
```

Query to search objects and products



### Example 
```objc

NSURL* file = [NSURL fileURLWithPath:@"/path/to/file.txt"]; // Image file to upload (only support jpg format yet)

SWGObjectApi*apiInstance = [[SWGObjectApi alloc] init];

// Query to search objects and products
[apiInstance getObjectsByImageFileWithFile:file
          completionHandler: ^(SWGGetObjectsResponse* output, NSError* error) {
                        if (output) {
                            NSLog(@"%@", output);
                        }
                        if (error) {
                            NSLog(@"Error calling SWGObjectApi->getObjectsByImageFile: %@", error);
                        }
                    }];
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **NSURL***| Image file to upload (only support jpg format yet) | 

### Return type

[**SWGGetObjectsResponse***](SWGGetObjectsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getObjectsByProductId**
```objc
-(NSURLSessionTask*) getObjectsByProductIdWithProductId: (NSString*) productId
        completionHandler: (void (^)(SWGGetObjectsByProductIdResponse* output, NSError* error)) handler;
```

Query to search multiple objects



### Example 
```objc

NSString* productId = @"productId_example"; // 

SWGObjectApi*apiInstance = [[SWGObjectApi alloc] init];

// Query to search multiple objects
[apiInstance getObjectsByProductIdWithProductId:productId
          completionHandler: ^(SWGGetObjectsByProductIdResponse* output, NSError* error) {
                        if (output) {
                            NSLog(@"%@", output);
                        }
                        if (error) {
                            NSLog(@"Error calling SWGObjectApi->getObjectsByProductId: %@", error);
                        }
                    }];
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **productId** | **NSString***|  | 

### Return type

[**SWGGetObjectsByProductIdResponse***](SWGGetObjectsByProductIdResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

