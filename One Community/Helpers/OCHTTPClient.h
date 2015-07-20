//
//  OCHTTPClient.h
//  One Community
//
//  Created by Gustavo Romito on 7/6/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface OCHTTPClient : AFHTTPRequestOperationManager

+ (OCHTTPClient *)privateClient;

@end
