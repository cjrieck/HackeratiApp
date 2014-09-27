//
//  HANetworkingManager.m
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/27/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "HANetworkingReachabilityManager.h"
#import "AFNetworking.h"

@interface HANetworkingReachabilityManager ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation HANetworkingReachabilityManager

- (instancetype)initWithURL:(NSURL *)baseURL
{
    self = [super init];
    if ( self ) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
        [self configureReachability];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appDidBecomeActive)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appWillResignActive)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
    }
    return self;
}

#pragma mark - Reachability

- (void)configureReachability
{
    NSOperationQueue *operationQueue = self.sessionManager.operationQueue;
    __block HANetworkingReachabilityManager *globalSelf = self;
    [self.sessionManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        switch ( status ) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                globalSelf.connectedToInternet = YES;
                globalSelf.connectedToWifi = NO;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                globalSelf.connectedToInternet = YES;
                globalSelf.connectedToWifi = YES;
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                globalSelf.connectedToInternet = NO;
                globalSelf.connectedToWifi = NO;
                break;
        }
    }];
}

- (void)appDidBecomeActive
{
    [self.sessionManager.reachabilityManager startMonitoring];
}

- (void)appWillResignActive
{
    [self.sessionManager.reachabilityManager stopMonitoring];
}

@end
