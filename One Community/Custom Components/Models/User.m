//
//  User.m
//  HG Network
//
//  Created by Gustavo Romito on 7/13/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithUserId:(NSNumber*)userId andUserName:(NSString *)user_name {
   self.user_id = userId;
   self.name = user_name;
   return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
   self.user_id = [dictionary valueForKey:@"id"];
   self.name = [NSString stringWithFormat:@"%@ %@",[dictionary valueForKey:@"first_name"],
                                                   [dictionary valueForKey:@"last_name"]];
   self.login = [dictionary valueForKey:@"login"];
   self.user_type = [[dictionary valueForKey:@"type_id"] integerValue];
   self.dob = [dictionary valueForKey:@"DOB"];
   self.week_hrs = [dictionary valueForKey:@"week_hrs"];
   self.extra_hrs = [dictionary valueForKey:@"extra_hrs"];
   self.tel = [dictionary valueForKey:@"tel"];
   self.mail = [dictionary valueForKey:@"mail"];
   
   return self;
}

@end
