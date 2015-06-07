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

- (UIColor *)grayscale {
   CGFloat *oldComponents = (CGFloat *)CGColorGetComponents([self CGColor]);
   CGFloat newComponents[4];
   
   int numComponents = CGColorGetNumberOfComponents([self CGColor]);
   
   switch (numComponents)
   {
      case 2:
      {
         //grayscale
         newComponents[0] = oldComponents[0]*0.7;
         newComponents[1] = oldComponents[0]*0.7;
         newComponents[2] = oldComponents[0]*0.7;
         newComponents[3] = oldComponents[1];
         break;
      }
      case 4:
      {
         //RGBA
         newComponents[0] = oldComponents[0]*0.7;
         newComponents[1] = oldComponents[1]*0.7;
         newComponents[2] = oldComponents[2]*0.7;
         newComponents[3] = oldComponents[3];
         break;
      }
   }
   
   CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
   CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
   CGColorSpaceRelease(colorSpace);
   
   UIColor *retColor = [UIColor colorWithCGColor:newColor];
   CGColorRelease(newColor);
   
   return retColor;
}

@end
