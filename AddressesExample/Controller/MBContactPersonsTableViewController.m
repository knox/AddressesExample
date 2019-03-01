//
//  AddressesExample
//
//  Copyright © 2019 Mikolas Bingemer. All rights reserved.
//

#import "MBContactPersonsTableViewController.h"
#import "MBContactPerson.h"

@interface MBContactPersonsTableViewController ()

@end

@implementation MBContactPersonsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.contactPersons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactPerson" forIndexPath:indexPath];

    MBContactPerson *contactPerson = [self contactPersonAtIndexPath:indexPath];
    [self configureCell:cell withContactPerson:contactPerson];

    return cell;
}

#pragma mark - MBContactPersonsTableViewController

- (MBContactPerson *)contactPersonAtIndexPath:(NSIndexPath *)indexPath {
    MBContactPerson *contactPerson;
    NSInteger idx = indexPath.row;
    if (idx >= 0 && idx < self.contactPersons.count) {
        contactPerson = self.contactPersons[(NSUInteger) idx];
    }
    return contactPerson;
}

- (void)configureCell:(UITableViewCell *)cell withContactPerson:(MBContactPerson *)contactPerson {
    NSString *fullName;
    if (contactPerson.lastName) {
        if (contactPerson.firstName) {
            fullName = [NSString stringWithFormat:@"%@, %@", contactPerson.lastName, contactPerson.firstName];
        } else {
            fullName = contactPerson.lastName;
        }
    } else {
        fullName = contactPerson.firstName;
    }
    cell.textLabel.text = fullName;
}

@end
