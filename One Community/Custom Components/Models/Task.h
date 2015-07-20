//
//  Task.h
//  One Community
//
//  Created by Gustavo Romito on 7/7/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Subtask.h"

@interface Task : NSObject

@property (strong, nonatomic) NSNumber *task_id;
@property (strong, nonatomic) NSNumber *status_id;
@property (strong, nonatomic) NSNumber *category_id;
@property (strong, nonatomic) NSString *category_name;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *beginning_date;
@property (strong, nonatomic) NSMutableArray *subTasks;

- (id) initWithDictionary:(NSDictionary *)dic;

@end
