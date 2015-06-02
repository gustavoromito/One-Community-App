//
//  OCProfileViewController.h
//  One Community
//
//  Created by Gustavo Romito on 6/1/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCBaseViewController.h"

@interface OCProfileViewController : OCBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIImageView *qrcodeImageView;
@property (nonatomic) NSIndexPath *lastIndex;
@end
