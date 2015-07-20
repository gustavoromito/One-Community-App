//
//  User.h
//  HG Network
//
//  Created by Gustavo Romito on 7/13/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RMMapper/NSObject+RMArchivable.h>

typedef NS_ENUM(NSUInteger, OCUserType) {
   OCUserTypeAdmin = 0,
   OCUserTypeManager = 1,
   OCUserTypeCollaborator = 2
};

@interface User : NSObject

@property (strong, nonatomic) NSNumber *user_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *login;
@property (nonatomic) OCUserType user_type;
@property (strong, nonatomic) NSString *dob;
@property (strong, nonatomic) NSNumber *week_hrs;
@property (strong, nonatomic) NSNumber *extra_hrs;
@property (strong, nonatomic) NSString *tel;
@property (strong, nonatomic) NSString *mail;

- (id)initWithUserId:(NSNumber*)userId andUserName:(NSString *)user_name;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
