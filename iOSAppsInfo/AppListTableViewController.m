//
//  AppListTableViewController.m
//  iOSAppsInfo
//
//  Created by 吴建国 on 15/11/14.
//  Copyright © 2015年 wujianguo. All rights reserved.
//

#import "AppListTableViewController.h"
#import "LMApp.h"
#import "LMAppController.h"
#import "AppDetailsTableViewController.h"

@interface AppListTableViewController ()
@property (nonatomic, retain) NSArray *apps;

@end

@implementation AppListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.apps = [LMAppController sharedInstance].installedApplications;
}

- (IBAction)startRefresh:(UIRefreshControl *)sender {
    [sender endRefreshing];
    self.apps = [LMAppController sharedInstance].installedApplications;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.apps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppTableViewCellIdentifier" forIndexPath:indexPath];
    LMApp *app = (LMApp *)self.apps[indexPath.row];
    cell.imageView.image = app.icon;
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = app.shortVersionString;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[AppDetailsTableViewController class]]) {
        AppDetailsTableViewController *dvc = (AppDetailsTableViewController*)segue.destinationViewController;
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            dvc.app = self.apps[indexPath.row];
        }
    }
}

@end
