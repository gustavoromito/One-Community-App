//
//  OCDashboardViewController.h
//  One Community
//
//  Created by Gustavo Romito on 6/16/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCBaseViewController.h"
#import "OCInputViewController.h"
#import "User.h"

@interface OCDashboardViewController : OCBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) User *outsideUser;

- (IBAction)addRowToSection:(id)sender;
- (IBAction)addComment:(id)sender;

@end
