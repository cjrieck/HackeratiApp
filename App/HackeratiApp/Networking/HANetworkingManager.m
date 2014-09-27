//
//  HANetworkingManager.m
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/27/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "HANetworkingManager.h"
#import "AFNetworking.h"

@interface HANetworkingManager ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation HANetworkingManager

- (instancetype)init
{
    self = [super init];
    if ( self ) {
        
    }
    return self;
}

@end
