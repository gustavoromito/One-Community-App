//
//  OCActivitiesViewController.h
//  One Community
//
//  Created by Gustavo Romito on 6/1/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCBaseViewController.h"

@interface OCActivitiesViewController : OCBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *segControl;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
