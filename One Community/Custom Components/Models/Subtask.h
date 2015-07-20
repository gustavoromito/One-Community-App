//
//  Subtask.h
//  One Community
//
//  Created by Gustavo Romito on 7/7/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface Subtask : NSObject

@property (strong, nonatomic) NSNumber *sub_task_id;
@property (strong, nonatomic) NSNumber *type_id;
@property (strong, nonatomic) NSNumber *time;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSArray *comments;
//@property (strong, nonatomic) Task *task;

//- (id) initWithDictionary:(NSDictionary *)dic andTask:(Task *)task;
- (id) initWithDictionary:(NSDictionary *)dic;

@end
