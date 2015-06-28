//
//  UIColor+MHelper.m
//  Moblyboy
//
//  Created by Gustavo Romito on 4/3/15.
//  Copyright (c) 2015 MKM Brasil. All rights reserved.
//

#import "UIColor+MHelper.h"
#import <HexColors/HexColor.h>

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

+ (NSArray *)gradientRedColors {
   return @[[UIColor colorWithHexString:@"ff002b"], [UIColor colorWithHexString:@"ff0015"], [UIColor colorWithHexString:@"ff0000"], [UIColor colorWithHexString:@"ff1500"], [UIColor colorWithHexString:@"ff2b00"]];
};

+ (NSArray *)gradientOrangeColors {
   return @[[UIColor colorWithHexString:@"ffa500"], [UIColor colorWithHexString:@"ff9000"], [UIColor colorWithHexString:@"ff9000"], [UIColor colorWithHexString:@"ff7b00"], [UIColor colorWithHexString:@"ff6600"]];
}

+ (NSArray *)gradientGreenColors {
   return @[[UIColor colorWithHexString:@"a7ce1e"], [UIColor colorWithHexString:@"98CE1E"], [UIColor colorWithHexString:@"89ce1e"], [UIColor colorWithHexString:@"7bce1e"], [UIColor colorWithHexString:@"6cce1e"]];
}

+ (NSArray *)gradientBlueColors {
   return @[[UIColor colorWithHexString:@"00afff"], [UIColor colorWithHexString:@"009aff"], [UIColor colorWithHexString:@"0084ff"], [UIColor colorWithHexString:@"006fff"], [UIColor colorWithHexString:@"005aff"]];
}

+ (NSArray *)gradientPurpleColors {
   return @[[UIColor colorWithHexString:@"9a43ac"], [UIColor colorWithHexString:@"9143ac"], [UIColor colorWithHexString:@"8843ac"], [UIColor colorWithHexString:@"7f43ac"], [UIColor colorWithHexString:@"7743ac"]];
}

+ (NSArray *)gradientMagentaColors {
   return @[[UIColor colorWithHexString:@"ff00ff"], [UIColor colorWithHexString:@"ff00ff"], [UIColor colorWithHexString:@"ff00ea"], [UIColor colorWithHexString:@"ff00d5"], [UIColor colorWithHexString:@"ff00bf"]];
}

@end
