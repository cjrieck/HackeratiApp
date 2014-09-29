//
//  AppDataModel.m
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/26/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "HAAppEntry.h"

static NSString * const kHAAppNameKey         = @"im:name";
static NSString * const kHAAppSummaryKey      = @"summary";
static NSString * const kHAAppPriceKey        = @"im:price";
static NSString * const kHAAppContentTypeKey  = @"im:contentType";
static NSString * const kHAAppCopyrightKey    = @"rights";
static NSString * const kHAAppStoreLinkKey    = @"link";
static NSString * const kHAAppCompanyKey      = @"im:artist";
static NSString * const kHAAppCategoryKey     = @"category";
static NSString * const kHAAppReleaseDateKey  = @"im:releaseDate";

static NSString * const kHAEntryAttributesKey = @"attributes";
static NSString * const kHAEntryLabelKey      = @"label";
static NSString * const kHAEntryHRefKey       = @"href";

// Core Data key constants
static NSString * const kHACoreDataEntityName = @"AppEntry";
static NSString * const kHACoreDataTitleKey = @"title";
static NSString * const kHACoreDataSummaryKey = @"summary";
static NSString * const kHACoreDataPriceKey = @"price";
static NSString * const kHACoreDataContentTypeKey = @"contentType";
static NSString * const kHACoreDataCopyrightKey = @"copyright";
static NSString * const kHACoreDataCompanyKey = @"company";
static NSString * const kHACoreDataCategoryKey = @"category";
static NSString * const kHACoreDataReleaseDateKey = @"releaseDate";
static NSString * const kHACoreDataStoreLinkKey = @"storeLink";

@interface HAAppEntry ()

@property (strong, nonatomic, readwrite) NSString *title;
@property (strong, nonatomic, readwrite) NSString *summary;
@property (strong, nonatomic, readwrite) NSString *price;
@property (strong, nonatomic, readwrite) NSString *contentType;
@property (strong, nonatomic, readwrite) NSString *copyright;
@property (strong, nonatomic, readwrite) NSString *company;
@property (strong, nonatomic, readwrite) NSString *category;
@property (strong, nonatomic, readwrite) NSString *releaseDate;
@property (strong, nonatomic, readwrite) NSString *storeLink;

@end

@implementation HAAppEntry

- (instancetype)initWithEntry:(NSDictionary *)appEntry
{
    self = [super init];
    if ( self ) {
        self.title = [self labelFromEntryData:[appEntry objectForKey:kHAAppNameKey]];
        self.summary = [self labelFromEntryData:[appEntry objectForKey:kHAAppSummaryKey]];
        self.price = [self labelFromEntryData:[appEntry objectForKey:kHAAppPriceKey]];
        self.contentType = [self labelFromEntryData:[[appEntry objectForKey:kHAAppContentTypeKey] objectForKey:kHAEntryAttributesKey]];
        self.copyright = [self labelFromEntryData:[appEntry objectForKey:kHAAppCopyrightKey]];
        self.company = [self labelFromEntryData:[appEntry objectForKey:kHAAppCompanyKey]];
        self.category = [self labelFromEntryData:[[appEntry objectForKey:kHAAppCategoryKey] objectForKey:kHAEntryAttributesKey]];
        self.releaseDate = [self labelFromEntryData:[[appEntry objectForKey:kHAAppReleaseDateKey] objectForKey:kHAEntryAttributesKey]];
        self.storeLink = [[[appEntry objectForKey:kHAAppStoreLinkKey] objectForKey:kHAEntryAttributesKey] objectForKey:kHAEntryHRefKey];
    }
    return self;
}

- (NSString *)labelFromEntryData:(NSDictionary *)metaData
{
    return [metaData objectForKey:kHAEntryLabelKey];
}

- (BOOL)saveToContext:(NSManagedObjectContext *)context
{
//    AppEntry *newEntry = [NSEntityDescription insertNewObjectForEntityForName:kHACoreDataEntityName inManagedObjectContext:context];
//    newEntry.title = self.title;
//    newEntry.summary = self.summary;
//    newEntry.price = self.price;
//    newEntry.contentType = self.contentType;
//    newEntry.copyright = self.copyright;
//    newEntry.company = self.company;
//    newEntry.category = self.category;
//    newEntry.releaseDate = self.releaseDate;
//    newEntry.storeLink = self.storeLink;
//    
//    NSError *error;
//    if ( ![context save:&error] ) {
//        NSLog(@"%@", error.localizedDescription);
//        return NO;
//    }
//    
//    return YES;
    return NO;
}

@end
