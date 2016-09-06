//
//  SchemeURLsTableViewController.m
//  iOSAppsInfo
//
//  Created by 吴建国 on 15/11/14.
//  Copyright © 2015年 wujianguo. All rights reserved.
//

#import "SchemeURLsTableViewController.h"
#import "LMAppController.h"

@interface SchemeURLsTableViewController ()
@property (nonatomic) NSInteger schemeType;
@property (nonatomic, retain) NSArray *publicURLSchemes;
@property (nonatomic, retain) NSArray *privateURLSchemes;
@end

@implementation SchemeURLsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.schemeType = 0;
    NSArray *publicURLSchemes = [[LMAppController sharedInstance] publicURLSchemes];
    NSArray *privateURLSchemes = [[LMAppController sharedInstance] privateURLSchemes];
    self.publicURLSchemes = [publicURLSchemes sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    self.privateURLSchemes = [privateURLSchemes sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (IBAction)schemeTypeChanged:(UISegmentedControl *)sender {
    self.schemeType = sender.selectedSegmentIndex;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.schemeType == 0) {
        return [self.publicURLSchemes count];
    } else {
        return [self.privateURLSchemes count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchemeTableViewCellIdentifier" forIndexPath:indexPath];
    if (self.schemeType == 0) {
        cell.textLabel.text = self.publicURLSchemes[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.textLabel.text = self.privateURLSchemes[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.schemeType == 0) {
        NSString *url = [NSString stringWithFormat:@"%@://app/", self.publicURLSchemes[indexPath.row]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    } else {
        NSString *url = [NSString stringWithFormat:@"%@://app/", self.privateURLSchemes[indexPath.row]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

@end
