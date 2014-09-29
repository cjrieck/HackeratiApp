//
//  HACoreDataManager.h
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/28/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import <CoreData/CoreData.h>

@class HAApp;

@interface HACoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)sharedManager;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)saveEntry:(HAApp *)appEntry;
- (void)deleteEntry:(HAApp *)appEntry;
- (NSArray *)fetchAllEntities;
- (BOOL)entryExists:(HAApp *)appEntry;

@end
