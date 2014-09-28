//
//  HADownloadProgressViewController.h
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/27/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

@protocol HADownloadProgressViewControllerDelegate <NSObject>

- (void)downloadProgressDidCompleteWithData:(id)data;

@end

@interface HADownloadProgressViewController : UIViewController

@property (weak, nonatomic) id<HADownloadProgressViewControllerDelegate>delegate;

- (instancetype)initWithURL:(NSURL *)url;

@end
