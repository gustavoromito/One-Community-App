//
//  Week.h
//  One Community
//
//  Created by Gustavo Romito on 7/8/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Week : NSObject

@property (strong, nonatomic) NSNumber *weekNumber;
@property (strong, nonatomic) NSMutableArray *tasks;
@property (strong, nonatomic) NSNumber *totalHours;

- (id)initWithWeekNumber:(NSNumber *)week;

@end
