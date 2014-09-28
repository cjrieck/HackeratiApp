//
//  HAAppListingTableViewDatasource.m
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/27/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "HAAppListingTableViewDatasource.h"
#import "HAAppEntry.h"

static NSString * const kHAAppEntryCellIdentifier = @"cell";

@interface HAAppListingTableViewDatasource ()

@property (strong, nonatomic, readwrite) NSMutableArray *appEntries;

@end

@implementation HAAppListingTableViewDatasource

- (instancetype)initWithEntries:(NSArray *)entries
{
    self = [super init];
    if ( self ) {
        _appEntries = [[NSMutableArray alloc] init];
        
        for (NSDictionary *entry in entries) {
            HAAppEntry *entryModel = [[HAAppEntry alloc] initWithEntry:entry];
            [_appEntries addObject:entryModel];
        }
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
    return self.appEntries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.listingDatasourceTableView dequeueReusableCellWithIdentifier:kHAAppEntryCellIdentifier];
    if ( cell ) {
        HAAppEntry *selectedEntry = [self.appEntries objectAtIndex:indexPath.row];
        cell.textLabel.text = selectedEntry.title;
    }
    return cell;
}

@end
