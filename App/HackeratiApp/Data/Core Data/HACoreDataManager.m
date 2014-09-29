//
//  HACoreDataManager.m
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/28/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "HACoreDataManager.h"
#import "HAAppEntry.h"
#import "HAApp.h"

static NSString * const kHACoreDataEntityName = @"HAAppEntry";

@implementation HACoreDataManager

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    static HACoreDataManager *s_sharedManager = nil;
    dispatch_once(&onceToken, ^{
        s_sharedManager = [[HACoreDataManager alloc] init];
    });
    return s_sharedManager;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.HA.HackeratiApp" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HackeratiApp" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HackeratiApp.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)saveEntry:(HAApp *)appEntry
{
    HAAppEntry *entryModel = [NSEntityDescription insertNewObjectForEntityForName:kHACoreDataEntityName inManagedObjectContext:self.managedObjectContext];
    
    entryModel.title = appEntry.title;
    entryModel.summary = appEntry.summary;
    entryModel.price = appEntry.price;
    entryModel.contentType = appEntry.contentType;
    entryModel.copyright = appEntry.copyright;
    entryModel.company = appEntry.company;
    entryModel.category = appEntry.category;
    entryModel.releaseDate = appEntry.releaseDate;
    entryModel.storeLink = appEntry.storeLink;
    
    NSError *error;
    if ( ![self.managedObjectContext save:&error] ) {
        NSLog(@"%@", error.localizedDescription);
    }
}

- (void)deleteEntry:(HAApp *)appEntry
{
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:kHACoreDataEntityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    // !!!: Assuming app title is a unique identifier/no other app in the App Store will have the same name
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"title == %@", appEntry.title];
    [fetchRequest setPredicate:filterPredicate];
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if ( results.count == 1 ) {
        // !!!: Assume there's only 1 entry in the array because title is unique
        [self.managedObjectContext deleteObject:results[0]];
    }
    
    if ( ![self.managedObjectContext save:&error] ) {
        NSLog(@"%@", error.localizedDescription);
    }
}

- (NSArray *)fetchAllEntities
{
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:kHACoreDataEntityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    NSArray *entities = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return entities;
}

- (BOOL)entryExists:(HAApp *)appEntry
{
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kHACoreDataEntityName];
    
    // !!!: Assuming app title is a unique identifier/no other app in the App Store will have the same name
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"title == %@", appEntry.title];
    [fetchRequest setPredicate:filterPredicate];
    [fetchRequest setFetchLimit:1];
    
    NSUInteger entityCount = [self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
    if ( entityCount == NSNotFound ) {
        NSLog(@"%@", error.localizedDescription);
    }
    else if ( entityCount == 1 ) {
        return YES;
    }
    
    return NO;
}

@end
