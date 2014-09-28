//
//  HANetworkingRequestManager.m
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/27/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "HANetworkingRequestManager.h"
#import "HANetworkingReachabilityManager.h"
#import <AFNetworking/AFNetworking.h>

static NSString * const kHAAppFeedKey = @"feed";
static NSString * const kHAAppEntriesKey = @"entry";

@interface HANetworkingRequestManager ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation HANetworkingRequestManager

- (instancetype)init
{
    self = [super init];
    if ( self ) {
        NSURLSessionConfiguration *urlConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:urlConfiguration];
    }
    return self;
}

- (void)downloadAppEntriesDataFromStringURL:(NSURL *)url
{
    NSParameterAssert(url);
    
    __block NSArray *entries;
    NSOperationQueue *queue = self.sessionManager.operationQueue;
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError *error;
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        entries = [[responseJSON objectForKey:kHAAppFeedKey] objectForKey:kHAAppEntriesKey];
        [self.delegate requestDidFinishDownloadingWithData:entries];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[[UIAlertView alloc] initWithTitle:@"There was an error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        [self.delegate requestDidFinishDownloadingWithData:nil];
    }];

    [queue addOperation:operation];
}

@end
