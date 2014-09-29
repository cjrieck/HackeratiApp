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

@interface HAEntryDetailViewController ()

@property (strong, nonatomic) HAApp *entry;
@property (strong, nonatomic) UIBarButtonItem *favoriteButton;
@property (strong, nonatomic) UIBarButtonItem *unfavoriteButton;
@end

@implementation HAEntryDetailViewController

- (instancetype)initWIthEntry:(HAApp *)entry
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

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)share
{
    // !!!: Sharing options (aside from Apple actions and custom actions) will only show up on a device
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.entry.storeLink] applicationActivities:nil];
    // Following spec for only copy, email and Twitter sharing capabilities. Remove this line to enable all possible sharing options
    activityViewController.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypePostToFacebook];
    activityViewController.popoverPresentationController.sourceView = self.view;
    activityViewController.popoverPresentationController.sourceRect = self.view.bounds;
    [self.navigationController presentViewController:activityViewController animated:YES completion:nil];
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

@end
