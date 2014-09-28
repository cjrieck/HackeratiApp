//
//  HAEntryDetailViewController.m
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/27/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "HAEntryDetailViewController.h"

@interface HAEntryDetailViewController ()

@property (strong, nonatomic) HAAppEntry *entry;

@end

@implementation HAEntryDetailViewController

- (instancetype)initWIthEntry:(HAAppEntry *)entry
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
