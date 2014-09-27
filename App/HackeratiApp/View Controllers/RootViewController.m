//
//  ViewController.m
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/23/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "RootViewController.h"
#import "HAAppListingTableViewDatasource.h"

@interface RootViewController ()

@property (strong, nonatomic) UITableView *appListingTableView;
@property (strong, nonatomic) HAAppListingTableViewDatasource *tableViewDatasource;

@end

@implementation RootViewController

- (instancetype)init
{
    self = [super init];
    if ( self ) {
        // localize for good will in this case
        self.title = NSLocalizedString(@"Hackerati App", @"title");
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor redColor];
    self.view.autoresizesSubviews = YES;
    
    UITableView *appListingTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    appListingTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // TODO: separate this init out and initialize in networking
    self.tableViewDatasource = [[HAAppListingTableViewDatasource alloc] initWithEntries:@[]];
    self.tableViewDatasource.listingDatasourceTableView = appListingTableView;
    appListingTableView.dataSource = self.tableViewDatasource;
    
    appListingTableView.delegate = self;
    [self.view addSubview:appListingTableView];
    _appListingTableView = appListingTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableView delegate methods

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Get app entry details at indexPath.row
    return indexPath;
}

@end
