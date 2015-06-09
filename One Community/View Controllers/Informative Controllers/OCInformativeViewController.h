//
//  OCInformativeViewController.h
//  One Community
//
//  Created by Gustavo Romito on 6/8/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCBaseWithouMenuViewController.h"
#import <ALThreeCircleSpinner/ALThreeCircleSpinner-Swift.h>

@interface OCInformativeViewController : OCBaseWithouMenuViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
