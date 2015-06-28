//
//  MCustomTableViewCell.m
//  Moblyboy
//
//  Created by Gustavo Romito on 3/1/15.
//  Copyright (c) 2015 MKM Brasil. All rights reserved.
//

#import "OCCustomTableViewCell.h"

@implementation OCCustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
   //   cell.progressBar.type = YLProgressBarTypeFlat;
   self.progressBar.progressBarInset = 0.0f;
   self.progressBar.behavior = YLProgressBarBehaviorIndeterminate;
   self.progressBar.stripesOrientation = YLProgressBarStripesOrientationVertical;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGSize)sizeThatFits:(CGSize)size
{
   CGFloat totalHeight = 0;
   totalHeight += [self.subText sizeThatFits:size].height;
   totalHeight += [self.extraText sizeThatFits:size].height;
   totalHeight += 50;
   return CGSizeMake(size.width, totalHeight);
}

- (void)setProgressBarColor:(NSArray *)colors {
   self.progressBar.progressTintColors = colors;
}

@end
