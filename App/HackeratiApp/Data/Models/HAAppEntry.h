//
//  AppDataModel.h
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/26/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

@interface HAAppEntry : NSObject

@property (strong, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSString *summary;
@property (strong, nonatomic, readonly) NSString *price;
@property (strong, nonatomic, readonly) NSString *copyright;
@property (strong, nonatomic, readonly) NSString *company;
@property (strong, nonatomic, readonly) NSString *contentType;
@property (strong, nonatomic, readonly) NSString *category;
@property (strong, nonatomic, readonly) NSString *releaseDate;
@property (strong, nonatomic, readonly) NSURL    *storeLink;

- (instancetype)initWithEntry:(NSDictionary *)appEntry;

@end
