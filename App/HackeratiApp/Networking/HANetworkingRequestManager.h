//
//  HANetworkingRequestManager.h
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/27/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

@protocol HANetworkingRequestManagerDelegate <NSObject>

- (void)requestDidFinishDownloadingWithData:(id)data;

@end

@interface HANetworkingRequestManager : NSObject

@property (weak, nonatomic) id<HANetworkingRequestManagerDelegate>delegate;

- (void)downloadAppEntriesDataFromStringURL:(NSURL *)url;

@end
