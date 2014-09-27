//
//  HANetworkingManager.h
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/27/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

@interface HANetworkingReachabilityManager : NSObject

@property (assign, nonatomic) BOOL connectedToWifi;
@property (assign, nonatomic) BOOL connectedToInternet;

- (instancetype)initWithURL:(NSURL *)baseURL;

@end
