#import <Foundation/Foundation.h>

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


@interface SWGQueryParamCollection : NSObject

@property(nonatomic, readonly) NSArray* values;
@property(nonatomic, readonly) NSString* format;

- (id) initWithValuesAndFormat: (NSArray*) values
                        format: (NSString*) format;

@end
