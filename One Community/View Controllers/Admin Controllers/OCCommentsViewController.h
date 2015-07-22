//
//  OCCommentsViewController.h
//  HG Network
//
//  Created by Gustavo Romito on 7/21/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCBaseWithouMenuViewController.h"

@interface OCCommentsViewController : OCBaseWithouMenuViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *outsideComments;

@end
