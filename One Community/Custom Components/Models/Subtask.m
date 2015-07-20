//
//  Subtask.m
//  One Community
//
//  Created by Gustavo Romito on 7/7/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "Subtask.h"

@implementation Subtask

- (id) initWithDictionary:(NSDictionary *)dic{
   self.sub_task_id = [dic valueForKey:@"sub_task_id"];
   self.type_id = [dic valueForKey:@"sub_task_type_id"];
   self.time = [dic valueForKey:@"sub_task_time"];
   self.name = [dic valueForKey:@"sub_task_name"];
   self.desc = [dic valueForKey:@"sub_task_description"];
   self.date = [dic valueForKey:@"sub_task_date"];
   self.comments = [dic objectForKey:@"comments"];
//   self.task = task;
   return self;
}

@end
