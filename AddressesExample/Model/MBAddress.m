//
//  AddressesExample
//
//  Copyright © 2019 Mikolas Bingemer. All rights reserved.
//


#import "MBAddress.h"
#import "MBContactPerson.h"


@implementation MBAddress

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
            @"identifier": @"id",
            @"companyName": @"company_name",
            @"lastName": @"last_name",
            @"firstName": @"first_name",
            @"street": @"street",
            @"zip": @"zip",
            @"city": @"city",
            @"isSupplier": @"is_supplier",
            @"isCustomer": @"is_customer",
            @"contactPersons": @"contact_persons",
    };
}

+ (NSValueTransformer *)contactPersonsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[MBContactPerson class]];
}

#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName {
    return @"Address";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{
            @"identifier": @"id",
            @"companyName": @"companyName",
            @"lastName": @"lastName",
            @"firstName": @"firstName",
            @"street": @"street",
            @"zip": @"zip",
            @"city": @"city",
            @"isSupplier": @"isSupplier",
            @"isCustomer": @"isCustomer",
            @"contactPersons": @"contactPersons",
    };
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithArray:@[@"identifier"]];
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{
            @"contactPersons": [MBContactPerson class],
    };
}

@end