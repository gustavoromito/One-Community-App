//
//  OCUrlHelper.h
//  One Community
//
//  Created by Gustavo Romito on 7/6/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCUrlHelper : NSObject

+ (NSURL *)apiBaseUrl;
+ (NSURL *)baseURLWith:(NSString *)specificComplement;

@end
