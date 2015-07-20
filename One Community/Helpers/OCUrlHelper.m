//
//  OCUrlHelper.m
//  One Community
//
//  Created by Gustavo Romito on 7/6/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCUrlHelper.h"

@implementation OCUrlHelper

+ (NSURL *)apiBaseUrl {
   NSDictionary *APIDic = [[NSBundle mainBundle]
                             objectForInfoDictionaryKey:@"OCAPI"];
   NSString *assembledURL = [NSString stringWithFormat:@"%@%@",
                                               [APIDic valueForKey:@"root"],
                                               [APIDic valueForKey:@"version"]];
   return [NSURL URLWithString:assembledURL];
}

+ (NSURL *)baseURLWith:(NSString *)specificComplement {
   NSString *baseURL = [[self apiBaseUrl] absoluteString];
   return [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", baseURL, specificComplement]];
}

@end
