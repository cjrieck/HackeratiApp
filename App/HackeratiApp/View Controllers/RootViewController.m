//
//  ViewController.m
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/23/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "RootViewController.h"
#import "HAAppListingTableViewDatasource.h"
#import "HANetworkingRequestManager.h"
#import "HADownloadProgressViewController.h"

static NSString * const kHARSSDataURL = @"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topgrossingapplications/sf=143441/limit=25/json";

@interface RootViewController () <HADownloadProgressViewControllerDelegate>

@property (strong, nonatomic) HANetworkingRequestManager *requestManager;
@property (strong, nonatomic) UITableView *appListingTableView;
@property (strong, nonatomic) HAAppListingTableViewDatasource *tableViewDatasource;
@property (strong, nonatomic) NSArray *entries;

@end

@implementation RootViewController

- (instancetype)init
{
    self = [super init];
    if ( self ) {
        // localize for good will in this case
        self.title = NSLocalizedString(@"Hackerati App", @"title");
        
        _requestManager = [[HANetworkingRequestManager alloc] init];
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
//    NSArray *entries = [self.requestManager downloadAppEntriesDataFromStringURL:kHARSSDataURL];
    
    appListingTableView.delegate = self;
    [self.view addSubview:appListingTableView];
    _appListingTableView = appListingTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *rssURL = [NSURL URLWithString:kHARSSDataURL];
    HADownloadProgressViewController *downloadVC = [[HADownloadProgressViewController alloc] initWithURL:rssURL];
    downloadVC.delegate = self;
    [self presentViewController:downloadVC animated:YES completion:nil];
}

#pragma mark - UITableView delegate methods

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Get app entry details at indexPath.row
    return indexPath;
}

#pragma mark - Download progress view controller delegate

- (void)downloadProgressDidCompleteWithData:(id)data
{
    if ( [data isKindOfClass:[NSArray class]] ) {
        self.entries = (NSArray *)data;
        self.tableViewDatasource = [[HAAppListingTableViewDatasource alloc] initWithEntries:self.entries];
        self.tableViewDatasource.listingDatasourceTableView = self.appListingTableView;
        self.appListingTableView.dataSource = self.tableViewDatasource;
        [self.appListingTableView reloadData];
    }
}

@end
