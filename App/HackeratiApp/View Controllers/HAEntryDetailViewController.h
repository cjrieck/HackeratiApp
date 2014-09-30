//
//  HAEntryDetailViewController.h
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/27/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "HAAppEntry.h"

@interface HAEntryDetailViewController : UIViewController

@property (assign, nonatomic) BOOL showFavorite;

- (instancetype)initWithEntry:(HAAppEntry *)entry;

@end
