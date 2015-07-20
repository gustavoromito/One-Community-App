//
//  Task.m
//  One Community
//
//  Created by Gustavo Romito on 7/7/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "Task.h"

@implementation Task

- (id) initWithDictionary:(NSDictionary *)dic {
   self.task_id = [dic valueForKey:@"task_id"];
   self.status_id = [dic valueForKey:@"task_status_id"];
   self.category_id = [dic valueForKey:@"category_id"];
   self.category_name = [dic valueForKey:@"category_name"];
   self.name = [dic valueForKey:@"task_name"];
   self.desc = [dic valueForKey:@"task_description"];
   self.beginning_date = [dic valueForKey:@"task_beginning_date"];
   self.subTasks = [[NSMutableArray alloc] init];
   return self;
}

@end
