//
//  HAFavoritesViewController.m
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/28/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "HAFavoritesViewController.h"
#import "HAEntryDetailViewController.h"
#import "HACoreDataManager.h"

static NSString * const kHACellReuseIdentifier = @"cell";

@interface HAFavoritesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *favoritesTableView;
@property (strong, nonatomic) NSArray *coreDataEntitiesArray;

@end

@implementation HAFavoritesViewController

- (instancetype)init
{
    self = [super init];
    if ( self ) {
        self.title = @"Favorites";
        
        self.coreDataEntitiesArray = [[HACoreDataManager sharedManager] fetchAllEntities];
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.autoresizesSubviews = YES;
    
    UITableView *favoritesTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [favoritesTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kHACellReuseIdentifier];
    favoritesTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    favoritesTableView.delegate = self;
    favoritesTableView.dataSource = self;
    favoritesTableView.tableFooterView.frame = CGRectZero;
    [self.view addSubview:favoritesTableView];
    _favoritesTableView = favoritesTableView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissController)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dismissController
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.coreDataEntitiesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.favoritesTableView dequeueReusableCellWithIdentifier:kHACellReuseIdentifier];
    if ( cell ) {
        HAAppEntry *entry = [self.coreDataEntitiesArray objectAtIndex:indexPath.row];
        cell.textLabel.text = entry.title;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HAAppEntry *selectedEntry = [self.coreDataEntitiesArray objectAtIndex:indexPath.row];
    HAEntryDetailViewController *detailViewController = [[HAEntryDetailViewController alloc] initWithEntry:selectedEntry];
    detailViewController.showFavorite = NO;
    [self.favoritesTableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
