//
//  HAEntryDetailViewController.m
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/27/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "HAEntryDetailViewController.h"
#import "HACoreDataManager.h"
#import "HAApp.h"

static NSString * const kHADetailsCellReuseIdentifier = @"cell";

@interface HAEntryDetailViewController () <UITableViewDataSource>

@property (strong, nonatomic) HAApp *entry;
@property (strong, nonatomic) UIBarButtonItem *favoriteButton;
@property (strong, nonatomic) UIBarButtonItem *unfavoriteButton;
@property (strong, nonatomic) UITableView *detailsTableView;

@end

@implementation HAEntryDetailViewController

- (instancetype)initWithEntry:(HAApp *)entry
{
    self = [super init];
    if ( self ) {
        self.title = entry.title;
        _entry = entry;
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.autoresizesSubviews = YES;
    
    UITableView *detailsTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [detailsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kHADetailsCellReuseIdentifier];
    detailsTableView.tableFooterView.frame = CGRectZero;
    detailsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    detailsTableView.dataSource = self;
    [self.view addSubview:detailsTableView];
    _detailsTableView = detailsTableView;
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    
    
    UIBarButtonItem *favoriteButton = [[UIBarButtonItem alloc] initWithTitle:@"Favorite"
                                                           style:UIBarButtonItemStylePlain
                                                          target:self
                                                          action:@selector(favorite)];
    _favoriteButton = favoriteButton;
    
    UIBarButtonItem *unfavoriteButton = [[UIBarButtonItem alloc] initWithTitle:@"Un-Favorite"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(unfavorite)];
    _unfavoriteButton = unfavoriteButton;
    
    if ( self.showFavorite ) {
        
        if ( [[HACoreDataManager sharedManager] entryExists:self.entry] ) {
            self.navigationItem.rightBarButtonItem = unfavoriteButton;
        }
        else {
            self.navigationItem.rightBarButtonItem = favoriteButton;
        }
    }
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                 target:self
                                                                                 action:@selector(share)];
    
    UIBarButtonItem *flexSpacing = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                 target:nil
                                                                                 action:nil];
    
    self.toolbarItems = @[shareButton, flexSpacing];
    
}

- (void)layoutSubviews
{
    [self.view layoutSubviews];
    
    CGRect tableViewFrame = self.detailsTableView.frame;
    tableViewFrame.size.height = self.detailsTableView.contentSize.height;
    self.detailsTableView.frame = tableViewFrame;
    
    [self.view layoutIfNeeded];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)share
{
    // !!!: Sharing options (e.g. Twitter), aside from Apple actions and custom actions, will only show up on a device. Only shares App Store URL for now
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.entry.storeLink] applicationActivities:nil];
    // Following spec for only copy, email and Twitter sharing capabilities. Remove this line to enable all possible sharing options
    activityViewController.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypePostToFacebook];
    activityViewController.popoverPresentationController.barButtonItem = [self.toolbarItems firstObject];
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:activityViewController];
        [popover presentPopoverFromRect:self.view.frame
                                 inView:self.view
               permittedArrowDirections:UIPopoverArrowDirectionAny
                               animated:YES];
    }
    else {
        [self.navigationController presentViewController:activityViewController animated:YES completion:nil];
    }
}

- (void)favorite
{
    [[HACoreDataManager sharedManager] saveEntry:self.entry];
    self.navigationItem.rightBarButtonItem = self.unfavoriteButton;
}

- (void)unfavorite
{
    [[HACoreDataManager sharedManager] deleteEntry:self.entry];
    self.navigationItem.rightBarButtonItem = self.favoriteButton;
}

- (void)orientationChanged
{
    [self.detailsTableView reloadData];
}

#pragma mark - UITableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.entry.enumeratedProperties.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.detailsTableView dequeueReusableCellWithIdentifier:kHADetailsCellReuseIdentifier];
    if ( cell ) {
        cell.textLabel.text = [self.entry.enumeratedProperties objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
    }
    
    return cell;
}

@end
