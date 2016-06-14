//
//  AppDetailsTableViewController.m
//  iOSAppsInfo
//
//  Created by 吴建国 on 15/11/14.
//  Copyright © 2015年 wujianguo. All rights reserved.
//

#import "AppDetailsTableViewController.h"
#import "LMAppController.h"

@interface AppDetailsTableViewController ()

@property NSString *appStoreUrl;
@property NSString *appStoreVersion;

@property (weak, nonatomic) IBOutlet UILabel *appStoreVersionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *appVersionLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bundleIdentifierLabel;
@property (weak, nonatomic) IBOutlet UILabel *applicationTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *diskUsageLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *minimumSystemVersionLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *vendorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sdkVersionLabel;

@end

@implementation AppDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sizeLabel.text = [NSString stringWithFormat:@"%.2fM", self.app.staticDiskUsage.doubleValue / 1024 / 1024];
    self.iconImage.image = self.app.icon;
    self.appNameLabel.text = self.app.name;
    self.appVersionLabel.text = [NSString stringWithFormat:@"version %@", self.app.shortVersionString];
    self.bundleIdentifierLabel.text = self.app.bundleIdentifier;
    self.applicationTypeLabel.text = self.app.applicationType;
    self.diskUsageLabel.text = [NSString stringWithFormat:@"%.2fM", self.app.dynamicDiskUsage.doubleValue / 1024 / 1024];
    self.itemIDLabel.text = [NSString stringWithFormat:@"%@", self.app.itemID];
    self.itemNameLabel.text = self.app.itemName;
    self.teamIDLabel.text = self.app.teamID;
    self.vendorNameLabel.text = self.app.vendorName;
    self.minimumSystemVersionLabel.text = self.app.minimumSystemVersion;
    self.sdkVersionLabel.text = self.app.sdkVersion;
    [self appStoreInfo];
}

- (void)appStoreInfo {
    NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@", self.app.itemID];
    NSURL *url = [NSURL URLWithString: urlStr];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"error: %@", error);
            return;
        }
        NSError *jsonError = nil;
        NSDictionary *resultJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        if (jsonError != nil) {
            NSLog(@"jsonError: %@", jsonError);
            return;
        }
        NSLog(@"%@", resultJSON);
        NSArray *results = resultJSON[@"results"];
        if ([results count] == 0) {
            return;
        }
        NSDictionary *detail = results[0];
        self.appStoreVersion = detail[@"version"];
        self.appStoreUrl = detail[@"trackViewUrl"];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", self.appStoreVersion);
            self.appStoreVersionLabel.text = self.appStoreVersion;
        });
    }] resume];
}

- (IBAction)actionButtonClick:(UIBarButtonItem *)sender {
    UIAlertController *actionController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [actionController addAction:[UIAlertAction actionWithTitle:@"open Application" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[LMAppController sharedInstance] openAppWithBundleIdentifier:self.app.bundleIdentifier];
    }]];
    [actionController addAction:[UIAlertAction actionWithTitle:@"open in App Store" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appStoreUrl]];
    }]];
    [actionController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }]];
    
    [self presentViewController:actionController animated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
