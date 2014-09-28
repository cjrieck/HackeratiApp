//
//  ViewController.m
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/23/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "HARootViewController.h"
#import "HAAppListingTableViewDatasource.h"
#import "HANetworkingRequestManager.h"
#import "HADownloadProgressViewController.h"
#import "HAEntryDetailViewController.h"

static NSString * const kHARSSDataURL = @"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topgrossingapplications/sf=143441/limit=25/json";

@interface HARootViewController () <HADownloadProgressViewControllerDelegate>

@property (strong, nonatomic) HANetworkingRequestManager *requestManager;
@property (strong, nonatomic) UITableView *appListingTableView;
@property (strong, nonatomic) HAAppListingTableViewDatasource *tableViewDatasource;

@end

@implementation HARootViewController

- (instancetype)init
{
    self = [super init];
    if ( self ) {
        // localize for good will in this case
        self.title = @"Hackerati App";
        
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:NO];
}

#pragma mark - UITableView delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HAAppEntry *selectedEntry = [self.tableViewDatasource.appEntries objectAtIndex:indexPath.row];
    HAEntryDetailViewController *detailViewController = [[HAEntryDetailViewController alloc] initWIthEntry:selectedEntry];
    [self.appListingTableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - Download progress view controller delegate

- (void)downloadProgressDidCompleteWithData:(id)data
{
    if ( [data isKindOfClass:[NSArray class]] ) {
        self.tableViewDatasource = [[HAAppListingTableViewDatasource alloc] initWithEntries:(NSArray *)data];
        self.tableViewDatasource.listingDatasourceTableView = self.appListingTableView;
        self.appListingTableView.dataSource = self.tableViewDatasource;
        [self.appListingTableView reloadData];
    }
}

@end