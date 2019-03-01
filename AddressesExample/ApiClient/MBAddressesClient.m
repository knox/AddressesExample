//
//  AddressesExample
//
//  Copyright © 2019 Mikolas Bingemer. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <OvercoatCoreData/OVCManagedStore.h>
#import <MTLManagedObjectAdapter/MTLManagedObjectAdapter.h>
#import <Overcoat/OVCResponse.h>
#import "MBRestClient.h"
#import "MBAddressesClient.h"
#import "MBAddress.h"


@interface MBAddressesClient ()

@property(nonatomic, strong) OVCManagedStore *managedStore;

@property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@property(strong, nonatomic) MBRestClient *restClient;

@end

@implementation MBAddressesClient

- (OVCManagedStore *)managedStore {

    if (!_managedStore) {
        _managedStore = [OVCManagedStore managedStoreWithCacheName:@"Addresses"];
    }

    return _managedStore;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = self.managedStore.persistentStoreCoordinator;
    }

    return _managedObjectContext;
}

- (NSFetchedResultsController *)fetchedResultsController {

    if (!_fetchedResultsController) {

        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Address"];
        [fetchRequest setFetchBatchSize:50];

        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isCustomer == true OR isSupplier == true"];
        [fetchRequest setPredicate:predicate];

        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES];
        [fetchRequest setSortDescriptors:@[sortDescriptor]];

        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    }

    return _fetchedResultsController;
}

- (MBRestClient *)restClient {

    if (!_restClient) {

        NSURL *baseURL = [NSURL URLWithString:@"https://addressapi.herokuapp.com/api/v1/"];
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];

        _restClient = [[MBRestClient alloc] initWithBaseURL:baseURL managedObjectContext:self.managedObjectContext sessionConfiguration:sessionConfiguration];
    }

    return _restClient;
}

#pragma mark - Public Methods

- (void)download {

    __weak typeof(self) weakSelf = self;
    void (^completion)(OVCResponse *, NSError *) =^(OVCResponse *response, NSError *error) {

        if (error) {
            NSLog(@"%s %@", __PRETTY_FUNCTION__, error);
        }

        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.delegate downloadCompleted];
    };

    [self.restClient GET:@"addresses" parameters:nil completion:completion];
}

- (BOOL)fetch {
    NSError *error = nil;
    BOOL result = [self.fetchedResultsController performFetch:&error];
    if (error) {
        NSLog(@"%s %@", __PRETTY_FUNCTION__, error);
    }

    return result;
}

- (NSInteger)count {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections firstObject];
    return sectionInfo.numberOfObjects;
}

- (MBAddress *)addressAtRow:(NSInteger)row {

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];

    NSError *error = nil;
    MBAddress *address = [MTLManagedObjectAdapter modelOfClass:[MBAddress class] fromManagedObject:object error:&error];

    if (error) {
        NSLog(@"%s %@ %@", __PRETTY_FUNCTION__, @(row), error);
    }

    return address;
}

@end