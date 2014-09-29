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

static NSString * const kHACoreDataEntityName = @"HAAppEntry";

@interface HAEntryDetailViewController ()

@property (strong, nonatomic) HAApp *entry;

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
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Favorite"
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self
                                                                              action:@selector(favorite)];
    
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
    NSURL *shareURL = [NSURL URLWithString:self.entry.storeLink];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[shareURL] applicationActivities:nil];
    // Following spec for only copy, email and Twitter sharing capabilities. Remove this line to enable all possible sharing options
    activityViewController.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypePostToFacebook];
    activityViewController.popoverPresentationController.sourceView = self.view;
    activityViewController.popoverPresentationController.sourceRect = self.view.bounds;
    [self.navigationController presentViewController:activityViewController animated:YES completion:nil];
}

- (void)favorite
{
    HAAppEntry *entryModel = [NSEntityDescription insertNewObjectForEntityForName:kHACoreDataEntityName inManagedObjectContext:[[HACoreDataManager sharedManager] managedObjectContext]];
    
    entryModel.title = self.entry.title;
    entryModel.summary = self.entry.summary;
    entryModel.price = self.entry.price;
    entryModel.contentType = self.entry.contentType;
    entryModel.copyright = self.entry.copyright;
    entryModel.company = self.entry.company;
    entryModel.category = self.entry.category;
    entryModel.releaseDate = self.entry.releaseDate;
    entryModel.storeLink = self.entry.storeLink;
    
    NSError *error;
    if ( ![[[HACoreDataManager sharedManager] managedObjectContext] save:&error] ) {
        NSLog(@"%@", error.localizedDescription);
    }
}

@end
