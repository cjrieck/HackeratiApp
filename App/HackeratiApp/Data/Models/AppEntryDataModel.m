//
//  AppDataModel.m
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/26/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "AppEntryDataModel.h"

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

@interface AppEntryDataModel ()

@property (strong, nonatomic, readwrite) NSString *title;
@property (strong, nonatomic, readwrite) NSString *summary;
@property (strong, nonatomic, readwrite) NSString *price;
@property (strong, nonatomic, readwrite) NSString *contentType;
@property (strong, nonatomic, readwrite) NSString *copyright;
@property (strong, nonatomic, readwrite) NSString *company;
@property (strong, nonatomic, readwrite) NSString *category;
@property (strong, nonatomic, readwrite) NSString *releaseDate;
@property (strong, nonatomic, readwrite) NSURL    *storeLink;

@end

@implementation AppEntryDataModel

- (instancetype)initWithEntry:(NSDictionary *)appEntry
{
    self = [super init];
    if ( self ) {
        _title = [self labelFromEntryData:[appEntry objectForKey:kHAAppNameKey]];
        _summary = [self labelFromEntryData:[appEntry objectForKey:kHAAppSummaryKey]];
        _price = [self labelFromEntryData:[appEntry objectForKey:kHAAppPriceKey]];
        _contentType = [self labelFromEntryData:[[appEntry objectForKey:kHAAppContentTypeKey] objectForKey:kHAEntryAttributesKey]];
        _copyright = [self labelFromEntryData:[appEntry objectForKey:kHAAppCopyrightKey]];
        _company = [self labelFromEntryData:[appEntry objectForKey:kHAAppCompanyKey]];
        _category = [self labelFromEntryData:[[appEntry objectForKey:kHAAppCategoryKey] objectForKey:kHAEntryAttributesKey]];
        _releaseDate = [self labelFromEntryData:[[appEntry objectForKey:kHAAppReleaseDateKey] objectForKey:kHAEntryAttributesKey]];
        
        NSString *stringURL = [self labelFromEntryData:[[[appEntry objectForKey:kHAAppStoreLinkKey] objectForKey:kHAEntryAttributesKey] objectForKey:kHAEntryHRefKey]];
        _storeLink = [NSURL URLWithString:stringURL];
    }
    return self;
}

- (NSString *)labelFromEntryData:(NSDictionary *)metaData
{
    return [metaData objectForKey:kHAEntryLabelKey];
}

@end
