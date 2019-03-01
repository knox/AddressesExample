//
//  AddressesExample
//
//  Copyright © 2019 Mikolas Bingemer. All rights reserved.
//

#import "MBRestClient.h"
#import "MBRestResponse.h"
#import "MBAddress.h"


@implementation MBRestClient

+ (NSDictionary *)responseClassesByResourcePath {
    return @{@"**": [MBRestResponse class]};
}

+ (NSDictionary *)modelClassesByResourcePath {
    return @{
            @"addresses": [MBAddress class]
    };
}

- (instancetype)initWithBaseURL:(OVC_NULLABLE NSURL *)url managedObjectContext:(OVC_NULLABLE NSManagedObjectContext *)context sessionConfiguration:(OVC_NULLABLE NSURLSessionConfiguration *)configuration {
    self = [super initWithBaseURL:url managedObjectContext:context sessionConfiguration:configuration];
    if (self) {
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }

    return self;
}

@end