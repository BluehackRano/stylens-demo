#import <Foundation/Foundation.h>
#import "SWGGetObjectsByProductIdResponse.h"
#import "SWGGetObjectsResponse.h"
#import "SWGApi.h"

/**
* style-api
* This is a API document for Stylens Service
*
* OpenAPI spec version: 0.0.1
* Contact: master@bluehack.net
*
* NOTE: This class is auto generated by the swagger code generator program.
* https://github.com/swagger-api/swagger-codegen.git
* Do not edit the class manually.
*/



@interface SWGObjectApi: NSObject <SWGApi>

extern NSString* kSWGObjectApiErrorDomain;
extern NSInteger kSWGObjectApiMissingParamErrorCode;

-(instancetype) initWithApiClient:(SWGApiClient *)apiClient NS_DESIGNATED_INITIALIZER;

/// Query to search objects and products
/// 
///
/// @param file Image file to upload (only support jpg format yet)
/// 
///  code:200 message:"successful operation",
///  code:400 message:"Invalid input"
///
/// @return SWGGetObjectsResponse*
-(NSURLSessionTask*) getObjectsByImageFileWithFile: (NSURL*) file
    completionHandler: (void (^)(SWGGetObjectsResponse* output, NSError* error)) handler;


/// Query to search multiple objects
/// 
///
/// @param productId 
/// 
///  code:200 message:"successful operation",
///  code:400 message:"Invalid input"
///
/// @return SWGGetObjectsByProductIdResponse*
-(NSURLSessionTask*) getObjectsByProductIdWithProductId: (NSString*) productId
    completionHandler: (void (^)(SWGGetObjectsByProductIdResponse* output, NSError* error)) handler;



@end
