//
//  AddressesExample
//
//  Copyright © 2019 Mikolas Bingemer. All rights reserved.
//

#import "MBAddressesViewController.h"
#import "MBAddressesClient.h"
#import "MBAddress.h"
#import "MBContactPersonsTableViewController.h"


@interface MBAddressesViewController () <MBAddressesClientDelegate>

@property(nonatomic, strong) MBAddressesClient *addressesClient;

@end

@implementation MBAddressesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];

    self.tableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];

    self.addressesClient = [[MBAddressesClient alloc] init];
    self.addressesClient.delegate = self;
    [self.addressesClient fetch];
    [self.addressesClient download];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.addressesClient count];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    MBAddress *address = [self.addressesClient addressAtRow:indexPath.row];

    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:NSStringFromSelector(@selector(identifier)) ascending:YES];
    NSArray <MBContactPerson *> *contactPersons = [address.contactPersons sortedArrayUsingDescriptors:@[sortDescriptor]];

    MBContactPersonsTableViewController *controller = [segue destinationViewController];
    controller.contactPersons = contactPersons;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Address" forIndexPath:indexPath];

    MBAddress *address = [self.addressesClient addressAtRow:indexPath.row];
    [self configureCell:cell withAddress:address];

    return cell;
}

#pragma mark - MBAddressesViewController

- (void)configureCell:(UITableViewCell *)cell withAddress:(MBAddress *)address {
    cell.textLabel.text = address.companyName;

    NSMutableString *detail;
    if (address.street) {
        detail = [NSMutableString stringWithString:address.street];
    }
    if (address.street) {
        if (detail) {
            [detail appendFormat:@", %@", address.zip];
        } else {
            detail = [NSMutableString stringWithString:address.zip];
        }
    }
    if (address.city) {
        if (detail) {
            [detail appendFormat:@", %@", address.city];
        } else {
            detail = [NSMutableString stringWithString:address.city];
        }
    }
    cell.detailTextLabel.text = detail;
}

- (void)refresh:(id)refresh {
    [self.addressesClient download];
}

#pragma mark - MBAddressesClientDelegate

- (void)downloadCompleted {

    [self.refreshControl endRefreshing];
    if ([self.addressesClient fetch]) {
        [self.tableView reloadData];
    }
}

@end
