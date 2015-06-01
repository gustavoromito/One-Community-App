//
//  MRoundedCornerView.m
//  Moblyboy
//
//  Created by Gustavo Romito on 4/11/15.
//  Copyright (c) 2015 MKM Brasil. All rights reserved.
//

#import "MRoundedCornerView.h"

@implementation MRoundedCornerView

- (id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self) {
      // Initialization code
   }
   return self;
}

- (void)awakeFromNib {
   [self.layer setCornerRadius:5.0f];
}

@end
