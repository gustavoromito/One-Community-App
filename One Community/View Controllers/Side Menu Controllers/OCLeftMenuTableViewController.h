//
//  MLeftMenuTableViewController.h
//  Moblyboy
//
//  Created by Gustavo Romito on 2/23/15.
//  Copyright (c) 2015 MKM Brasil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCBaseWithouMenuViewController.h"

@interface OCLeftMenuTableViewController : OCBaseWithouMenuViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *optionsTableView;

@end
