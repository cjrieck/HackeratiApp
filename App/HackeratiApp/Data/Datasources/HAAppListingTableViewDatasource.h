//
//  HAAppListingTableViewDatasource.h
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/27/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

@interface HAAppListingTableViewDatasource : NSObject <UITableViewDataSource>

@property (weak, nonatomic) UITableView *listingDatasourceTableView;
@property (strong, nonatomic, readonly) NSMutableArray *appEntries;

- (instancetype)initWithEntries:(NSArray *)entries;

@end
