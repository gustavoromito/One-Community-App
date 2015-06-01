//
//  MFlatButton.m
//  Moblyboy
//
//  Created by Gustavo Romito on 4/3/15.
//  Copyright (c) 2015 MKM Brasil. All rights reserved.
//

#import "MFlatButton.h"
#import "UIColor+MHelper.h"

@implementation MFlatButton

- (id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self) {
      // Initialization code
   }
   return self;
}

- (void)awakeFromNib {
   [self setTitleColor:[self.titleLabel.textColor inverseColor] forState:UIControlStateHighlighted];
}

@end
