#import "SWGBoxObject.h"

@implementation SWGBoxObject

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
  return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{ @"box": @"box", @"classCode": @"class_code", @"className": @"class_name", @"score": @"score", @"products": @"products" }];
}

/**
 * Indicates whether the property with the given name is optional.
 * If `propertyName` is optional, then return `YES`, otherwise return `NO`.
 * This method is used by `JSONModel`.
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName {

  NSArray *optionalProperties = @[@"box", @"classCode", @"className", @"score", @"products"];
  return [optionalProperties containsObject:propertyName];
}

@end
