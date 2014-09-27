//
//  HAAppListingTableViewDatasource.m
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/27/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "HAAppListingTableViewDatasource.h"
#import "AppEntryDataModel.h"

static NSString * const kHAAppEntryCellIdentifier = @"cell";

@interface HAAppListingTableViewDatasource ()

@property (strong, nonatomic) NSMutableArray *appEntries;

@end

@implementation HAAppListingTableViewDatasource

- (instancetype)initWithEntries:(NSArray *)entries
{
    self = [super init];
    if ( self ) {
        // TODO: Iterate over entries and create models from each and append to appEntries
    }
    return self;
}

- (void)setListingDatasourceTableView:(UITableView *)listingDatasourceTableView
{
    _listingDatasourceTableView = listingDatasourceTableView;
    [_listingDatasourceTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kHAAppEntryCellIdentifier];
}

#pragma mark - UITableView datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
    //return self.appEntries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.listingDatasourceTableView dequeueReusableCellWithIdentifier:kHAAppEntryCellIdentifier];
    if ( cell ) {
        // Set cell title equal to title in model
        cell.textLabel.text = @"test";
    }
    return cell;
}

@end
