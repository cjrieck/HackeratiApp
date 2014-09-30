//
//  HADetailCellLabel.m
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/29/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "HADetailCellLabel.h"

@implementation HADetailCellLabel

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    CGFloat width = CGRectGetWidth(bounds);
    if ( self.preferredMaxLayoutWidth != width ) {
        self.preferredMaxLayoutWidth = width;
    }
}

@end
