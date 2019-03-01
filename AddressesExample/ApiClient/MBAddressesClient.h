//
//  AddressesExample
//
//  Copyright © 2019 Mikolas Bingemer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBAddress;


@protocol MBAddressesClientDelegate <NSObject>

- (void)downloadCompleted;

@end

@interface MBAddressesClient : NSObject

@property(nonatomic, weak) id <MBAddressesClientDelegate> delegate;

- (void)download;

- (BOOL)fetch;

- (NSInteger)count;

- (MBAddress *)addressAtRow:(NSInteger)row;

@end