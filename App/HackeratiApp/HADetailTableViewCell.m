//
//  HADetailTableViewCell.m
//  HackeratiApp
//
//  Created by Clayton Rieck on 9/29/14.
//  Copyright (c) 2014 HA. All rights reserved.
//

#import "HADetailTableViewCell.h"
#import "HADetailCellLabel.h"

@interface HADetailTableViewCell ()

@property (strong, nonatomic) HADetailCellLabel *contentTextLabel;

@end

@implementation HADetailTableViewCell

- (void)awakeFromNib {
    _contentTextLabel.frame = CGRectZero;
    _contentTextLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle:(NSString *)title
{
    self.contentTextLabel.text = title;
}

@end
