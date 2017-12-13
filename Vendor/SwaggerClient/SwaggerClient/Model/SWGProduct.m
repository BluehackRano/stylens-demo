#import "SWGProduct.h"

@implementation SWGProduct

- (instancetype)init {
  self = [super init];
  if (self) {
    // initialize property's default value, if any
    
  }
  return self;
}


/**
 * Maps json key to property name.
 * This method is used by `JSONModel`.
 */
+ (JSONKeyMapper *)keyMapper {
  return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{ @"_id": @"id", @"name": @"name", @"hostCode": @"host_code", @"hostUrl": @"host_url", @"hostName": @"host_name", @"tags": @"tags", @"classCode": @"class_code", @"price": @"price", @"currencyUnit": @"currency_unit", @"productUrl": @"product_url", @"productNo": @"product_no", @"nation": @"nation", @"mainImage": @"main_image", @"mainImageMobileFull": @"main_image_mobile_full", @"mainImageMobileThumb": @"main_image_mobile_thumb", @"sizes": @"sizes", @"discountRate": @"discount_rate", @"version": @"version" }];
}

/**
 * Indicates whether the property with the given name is optional.
 * If `propertyName` is optional, then return `YES`, otherwise return `NO`.
 * This method is used by `JSONModel`.
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName {

  NSArray *optionalProperties = @[@"_id", @"name", @"hostCode", @"hostUrl", @"hostName", @"tags", @"classCode", @"price", @"currencyUnit", @"productUrl", @"productNo", @"nation", @"mainImage", @"mainImageMobileFull", @"mainImageMobileThumb", @"sizes", @"discountRate", @"version"];
  return [optionalProperties containsObject:propertyName];
}

@end
