//
//  AddressesExample
//
//  Copyright © 2019 Mikolas Bingemer. All rights reserved.
//

#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>
#import <MTLManagedObjectAdapter/MTLManagedObjectAdapter.h>

@class MBContactPerson;

@interface MBAddress : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property(nonatomic, assign, readonly) NSUInteger identifier;
@property(nonatomic, copy, readonly) NSString *companyName;
@property(nonatomic, copy, readonly) NSString *firstName;
@property(nonatomic, copy, readonly) NSString *lastName;
@property(nonatomic, copy, readonly) NSString *street;
@property(nonatomic, copy, readonly) NSString *zip;
@property(nonatomic, copy, readonly) NSString *city;
@property(nonatomic, assign, readonly) BOOL isSupplier;
@property(nonatomic, assign, readonly) BOOL isCustomer;
@property(nonatomic, strong, readonly) NSSet <MBContactPerson *> *contactPersons;

@end