//
//  Week.m
//  One Community
//
//  Created by Gustavo Romito on 7/8/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "Week.h"

@implementation Week

- (id)initWithWeekNumber:(NSNumber *)week {
   self.weekNumber = week;
   self.tasks = [[NSMutableArray alloc] init];
   return self;
}

@end
