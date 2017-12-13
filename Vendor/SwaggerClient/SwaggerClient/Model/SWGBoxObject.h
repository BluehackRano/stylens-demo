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


#import "SWGBox.h"
#import "SWGProduct.h"


@protocol SWGBoxObject
@end

@interface SWGBoxObject : SWGObject


@property(nonatomic) SWGBox* box;

@property(nonatomic) NSString* classCode;

@property(nonatomic) NSString* className;

@property(nonatomic) NSNumber* score;

@property(nonatomic) NSArray<SWGProduct>* products;

@end
