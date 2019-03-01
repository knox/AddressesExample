//
//  AddressesExample
//
//  Copyright © 2019 Mikolas Bingemer. All rights reserved.
//

#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>
#import <MTLManagedObjectAdapter/MTLManagedObjectAdapter.h>

@class MBAddress;


@interface MBContactPerson : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property(nonatomic, assign, readonly) NSUInteger identifier;
@property(nonatomic, copy, readonly) NSString *firstName;
@property(nonatomic, copy, readonly) NSString *lastName;
@property(nonatomic, strong, readonly) MBAddress *address;

@end