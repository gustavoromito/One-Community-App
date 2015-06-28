//
//  OCDashboardViewController.h
//  One Community
//
//  Created by Gustavo Romito on 6/16/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCBaseViewController.h"

@interface OCDashboardViewController : OCBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)addRowToSection:(id)sender;
@end
