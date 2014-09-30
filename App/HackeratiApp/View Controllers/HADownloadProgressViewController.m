//
//  HADownloadProgressViewController.m
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/27/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "HADownloadProgressViewController.h"
#import "HANetworkingRequestManager.h"
#import <AFNetworking/AFNetworking.h>

@interface HADownloadProgressViewController () <HANetworkingRequestManagerDelegate>

@property (strong, nonatomic) HANetworkingRequestManager *requestManager;
@property (strong, nonatomic) NSURL *dataURL;
@property (strong, nonatomic) UIProgressView *progressView;

@end

@implementation HADownloadProgressViewController

- (instancetype)initWithURL:(NSURL *)url
{
    self = [super init];
    if ( self ) {
        _dataURL = url;
        _requestManager = [[HANetworkingRequestManager alloc] init];
        _requestManager.delegate = self;
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.autoresizesSubviews = YES;
    
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    progressView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    progressView.center = self.view.center;
    progressView.backgroundColor = [UIColor colorWithWhite:0.765 alpha:1.000];
    progressView.tintColor = [UIColor colorWithRed:0.071 green:0.421 blue:0.944 alpha:1.000];
    [self.view addSubview:progressView];
    _progressView = progressView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startDownloadProgressBarWithURL:self.dataURL];
}

- (void)startDownloadProgressBarWithURL:(NSURL *)url
{
    __weak typeof(self) weakSelf = self;
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    AFURLConnectionOperation *connectionOperation = [[AFURLConnectionOperation alloc] initWithRequest:urlRequest];
    [connectionOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead){
        
        if ( totalBytesExpectedToRead == NSURLResponseUnknownLength ) {
            totalBytesExpectedToRead = 1.0f;
        }
        
        float percentageDone = (float)(totalBytesRead / totalBytesExpectedToRead);
        if ( percentageDone >= 1.0f ) {
            [weakSelf.progressView setProgress:1.0f animated:YES];
        }
        else {
            [weakSelf.progressView setProgress:percentageDone animated:YES];
        }
    }];
    
    [self.requestManager downloadAppEntriesDataFromStringURL:url];
    
    [connectionOperation start];
}

#pragma mark - HANetworking delegate

- (void)requestDidFinishDownloadingWithData:(id)data
{
    if ( data ) {
        [self.delegate downloadProgressDidCompleteWithData:data];
        
        [UIView animateWithDuration:1.0f
                         animations:^{
                             self.progressView.alpha = 0.0f;
                         }
                         completion:nil];
        
        UILabel *thankYouLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        thankYouLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        thankYouLabel.center = self.view.center;
        thankYouLabel.text = NSLocalizedString(@"Download Complete!", @"completion message");
        thankYouLabel.font = [UIFont systemFontOfSize:25.0];
        thankYouLabel.textAlignment = NSTextAlignmentCenter;
        thankYouLabel.alpha = 0.0f;
        [self.view addSubview:thankYouLabel];
        
        [UIView animateWithDuration:0.5f
                              delay:0.5f
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             thankYouLabel.alpha = 1.0f;
                         }
                         completion:^(BOOL finished){
                             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 [self dismissViewControllerAnimated:YES completion:nil];
                             });
                         }];
    }
}

@end
