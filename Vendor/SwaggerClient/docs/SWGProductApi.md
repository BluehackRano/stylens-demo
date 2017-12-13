# SWGProductApi

All URIs are relative to *http://api.stylelens.io*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getProductByHostcodeAndProductNo**](SWGProductApi.md#getproductbyhostcodeandproductno) | **GET** /products/hosts/{hostCode}/products/{productNo} | Get Product by hostCode and productNo
[**getProductById**](SWGProductApi.md#getproductbyid) | **GET** /products/{productId} | Find Product by ID
[**getProducts**](SWGProductApi.md#getproducts) | **GET** /products | Get Products by productId
[**getProductsByImageFile**](SWGProductApi.md#getproductsbyimagefile) | **POST** /products/images | Query to search products
[**getProductsByImageIdAndObjectId**](SWGProductApi.md#getproductsbyimageidandobjectid) | **GET** /products/images/{imageId}/objects/{objectId} | Get Products by imageId and objectId


# **getProductByHostcodeAndProductNo**
```objc
-(NSURLSessionTask*) getProductByHostcodeAndProductNoWithHostCode: (NSString*) hostCode
    productNo: (NSString*) productNo
        completionHandler: (void (^)(SWGGetProductResponse* output, NSError* error)) handler;
```

Get Product by hostCode and productNo

Returns Product belongs to a Host and productNo

### Example 
```objc

NSString* hostCode = @"hostCode_example"; // 
NSString* productNo = @"productNo_example"; // 

SWGProductApi*apiInstance = [[SWGProductApi alloc] init];

// Get Product by hostCode and productNo
[apiInstance getProductByHostcodeAndProductNoWithHostCode:hostCode
              productNo:productNo
          completionHandler: ^(SWGGetProductResponse* output, NSError* error) {
                        if (output) {
                            NSLog(@"%@", output);
                        }
                        if (error) {
                            NSLog(@"Error calling SWGProductApi->getProductByHostcodeAndProductNo: %@", error);
                        }
                    }];
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **hostCode** | **NSString***|  | 
 **productNo** | **NSString***|  | 

### Return type

[**SWGGetProductResponse***](SWGGetProductResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProductById**
```objc
-(NSURLSessionTask*) getProductByIdWithProductId: (NSString*) productId
        completionHandler: (void (^)(SWGGetProductResponse* output, NSError* error)) handler;
```

Find Product by ID

Returns a single Product

### Example 
```objc

NSString* productId = @"productId_example"; // ID of Product to return

SWGProductApi*apiInstance = [[SWGProductApi alloc] init];

// Find Product by ID
[apiInstance getProductByIdWithProductId:productId
          completionHandler: ^(SWGGetProductResponse* output, NSError* error) {
                        if (output) {
                            NSLog(@"%@", output);
                        }
                        if (error) {
                            NSLog(@"Error calling SWGProductApi->getProductById: %@", error);
                        }
                    }];
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **productId** | **NSString***| ID of Product to return | 

### Return type

[**SWGGetProductResponse***](SWGGetProductResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProducts**
```objc
-(NSURLSessionTask*) getProductsWithProductId: (NSString*) productId
    offset: (NSNumber*) offset
    limit: (NSNumber*) limit
        completionHandler: (void (^)(SWGGetProductsResponse* output, NSError* error)) handler;
```

Get Products by productId

Returns similar Products with productId

### Example 
```objc

NSString* productId = @"productId_example"; // 
NSNumber* offset = @56; //  (optional)
NSNumber* limit = @56; //  (optional)

SWGProductApi*apiInstance = [[SWGProductApi alloc] init];

// Get Products by productId
[apiInstance getProductsWithProductId:productId
              offset:offset
              limit:limit
          completionHandler: ^(SWGGetProductsResponse* output, NSError* error) {
                        if (output) {
                            NSLog(@"%@", output);
                        }
                        if (error) {
                            NSLog(@"Error calling SWGProductApi->getProducts: %@", error);
                        }
                    }];
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **productId** | **NSString***|  | 
 **offset** | **NSNumber***|  | [optional] 
 **limit** | **NSNumber***|  | [optional] 

### Return type

[**SWGGetProductsResponse***](SWGGetProductsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProductsByImageFile**
```objc
-(NSURLSessionTask*) getProductsByImageFileWithFile: (NSURL*) file
    offset: (NSNumber*) offset
    limit: (NSNumber*) limit
        completionHandler: (void (^)(SWGGetProductsResponse* output, NSError* error)) handler;
```

Query to search products



### Example 
```objc

NSURL* file = [NSURL fileURLWithPath:@"/path/to/file.txt"]; // Image file to upload (only support jpg format yet) (optional)
NSNumber* offset = @56; //  (optional)
NSNumber* limit = @56; //  (optional)

SWGProductApi*apiInstance = [[SWGProductApi alloc] init];

// Query to search products
[apiInstance getProductsByImageFileWithFile:file
              offset:offset
              limit:limit
          completionHandler: ^(SWGGetProductsResponse* output, NSError* error) {
                        if (output) {
                            NSLog(@"%@", output);
                        }
                        if (error) {
                            NSLog(@"Error calling SWGProductApi->getProductsByImageFile: %@", error);
                        }
                    }];
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **NSURL***| Image file to upload (only support jpg format yet) | [optional] 
 **offset** | **NSNumber***|  | [optional] 
 **limit** | **NSNumber***|  | [optional] 

### Return type

[**SWGGetProductsResponse***](SWGGetProductsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProductsByImageIdAndObjectId**
```objc
-(NSURLSessionTask*) getProductsByImageIdAndObjectIdWithImageId: (NSString*) imageId
    objectId: (NSNumber*) objectId
        completionHandler: (void (^)(SWGGetProductsResponse* output, NSError* error)) handler;
```

Get Products by imageId and objectId

Returns Products belongs to a imageId and objectId

### Example 
```objc

NSString* imageId = @"imageId_example"; // 
NSNumber* objectId = @56; // 

SWGProductApi*apiInstance = [[SWGProductApi alloc] init];

// Get Products by imageId and objectId
[apiInstance getProductsByImageIdAndObjectIdWithImageId:imageId
              objectId:objectId
          completionHandler: ^(SWGGetProductsResponse* output, NSError* error) {
                        if (output) {
                            NSLog(@"%@", output);
                        }
                        if (error) {
                            NSLog(@"Error calling SWGProductApi->getProductsByImageIdAndObjectId: %@", error);
                        }
                    }];
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **imageId** | **NSString***|  | 
 **objectId** | **NSNumber***|  | 

### Return type

[**SWGGetProductsResponse***](SWGGetProductsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

