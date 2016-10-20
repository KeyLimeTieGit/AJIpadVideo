//
//  VideoTableViewCell.m
//  iPadVideoTest
//
//  Created by Sameer Siddiqui on 10/14/16.
//  Copyright © 2016 KeyLimeTie. All rights reserved.
//

#import "VideoTableViewCell.h"


@interface VideoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *videoThumb;


@end

@implementation VideoTableViewCell {
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.titleLabel.text = @"Bunny test video";
    self.descriptionLabel.text = @"This is a test video. Authorized for AJ use only.";
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

@end
