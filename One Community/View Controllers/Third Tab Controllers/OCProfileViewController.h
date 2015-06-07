//
//  OCProfileViewController.h
//  One Community
//
//  Created by Gustavo Romito on 6/1/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCBaseViewController.h"
#import <ParallaxBlur/JPBFloatingTextViewController.h>

@interface OCProfileViewController : JPBFloatingTextViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *optionsTableView;
@property (strong, nonatomic) IBOutlet UIImageView *qrcodeImageView;
@property (nonatomic) NSIndexPath *lastIndex;
@end
