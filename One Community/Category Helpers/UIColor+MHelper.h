//
//  UIColor+MHelper.h
//  Moblyboy
//
//  Created by Gustavo Romito on 4/3/15.
//  Copyright (c) 2015 MKM Brasil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MHelper)

- (UIColor *)inverseColor;
- (UIColor *)grayscale;

+ (NSArray *)gradientRedColors;
+ (NSArray *)gradientOrangeColors;
+ (NSArray *)gradientGreenColors;
+ (NSArray *)gradientBlueColors;
+ (NSArray *)gradientPurpleColors;
+ (NSArray *)gradientMagentaColors;

@end
