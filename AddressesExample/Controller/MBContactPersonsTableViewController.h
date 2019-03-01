//
//  AddressesExample
//
//  Copyright © 2019 Mikolas Bingemer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBContactPerson;

NS_ASSUME_NONNULL_BEGIN

@interface MBContactPersonsTableViewController : UITableViewController

@property (nonatomic, strong) NSArray <MBContactPerson *> *contactPersons;

@end

NS_ASSUME_NONNULL_END
