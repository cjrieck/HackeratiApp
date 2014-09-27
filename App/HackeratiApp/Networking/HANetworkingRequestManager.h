//
//  HANetworkingRequestManager.h
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/27/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HANetworkingRequestManager : NSObject

- (NSArray *)downloadAppEntriesDataFromStringURL:(NSString *)urlString;

@end
