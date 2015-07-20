//
//  OCHTTPClient.m
//  One Community
//
//  Created by Gustavo Romito on 7/6/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCHTTPClient.h"
#import "OCUrlHelper.h"

@implementation OCHTTPClient

+ (OCHTTPClient *)privateClient {
   static OCHTTPClient *_sharedClient = nil;
   _sharedClient = [[OCHTTPClient alloc]
                    initWithBaseURL:[OCUrlHelper apiBaseUrl]];
   return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
   self = [super initWithBaseURL:url];
   if (!self) return nil;
   self.requestSerializer = [AFJSONRequestSerializer serializer];
   [self.requestSerializer setValue:@"application/json"
                 forHTTPHeaderField:@"Content-Type"];
   
   [self.requestSerializer setValue:[[[NSBundle mainBundle] objectForInfoDictionaryKey:@"OCAPI"]
                                                   valueForKey:@"mobile-token"]
                 forHTTPHeaderField:@"mobile-token"];
   
   [self.requestSerializer setValue:@"/json"
                 forHTTPHeaderField:@"Accept"];
   return self;
}

@end
