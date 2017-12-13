#import <Foundation/Foundation.h>
#import "SWGObject.h"

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


#import "SWGProduct.h"


@protocol SWGGetProductResponse
@end

@interface SWGGetProductResponse : SWGObject


@property(nonatomic) NSString* message;

@property(nonatomic) SWGProduct* data;

@end
