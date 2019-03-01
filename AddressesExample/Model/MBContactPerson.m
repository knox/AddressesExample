//
//  AddressesExample
//
//  Copyright © 2019 Mikolas Bingemer. All rights reserved.
//

#import "MBContactPerson.h"
#import "MBAddress.h"


@implementation MBContactPerson

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
            @"identifier": @"id",
            @"lastName": @"last_name",
            @"firstName": @"first_name",
    };
}

#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName {
    return @"ContactPerson";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{
            @"identifier" : @"id",
            @"lastName" : @"lastName",
            @"firstName" : @"firstName",
            @"address" : @"address",
    };
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithArray:@[ @"identifier"]];
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{
            @"address" : [MBAddress class],
    };
}

@end