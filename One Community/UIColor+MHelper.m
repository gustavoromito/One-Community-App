//
//  UIColor+MHelper.m
//  Moblyboy
//
//  Created by Gustavo Romito on 4/3/15.
//  Copyright (c) 2015 MKM Brasil. All rights reserved.
//

#import "UIColor+MHelper.h"

@implementation UIColor (MHelper)

- (UIColor *)inverseColor {
   
   CGColorRef oldCGColor = self.CGColor;
   
   int numberOfComponents = (int)CGColorGetNumberOfComponents(oldCGColor);
   
   // can not invert - the only component is the alpha
   // e.g. self == [UIColor groupTableViewBackgroundColor]
   if (numberOfComponents == 1) {
      return [UIColor colorWithCGColor:oldCGColor];
   }
   
   const CGFloat *oldComponentColors = CGColorGetComponents(oldCGColor);
   CGFloat newComponentColors[numberOfComponents];
   
   int i = numberOfComponents - 1;
   newComponentColors[i] = oldComponentColors[i]; // alpha
   while (--i >= 0) {
      newComponentColors[i] = 1 - oldComponentColors[i];
   }
   
   CGColorRef newCGColor = CGColorCreate(CGColorGetColorSpace(oldCGColor), newComponentColors);
   UIColor *newColor = [UIColor colorWithCGColor:newCGColor];
   CGColorRelease(newCGColor);
   
   return newColor;
}

@end
