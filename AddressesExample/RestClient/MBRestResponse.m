//
//  AddressesExample
//
//  Copyright © 2019 Mikolas Bingemer. All rights reserved.
//

#import "MBRestResponse.h"


@implementation MBRestResponse

+ (NSString *)resultKeyPathForJSONDictionary:(NSDictionary *)JSONDictionary {
    return @"addresses";
}

@end