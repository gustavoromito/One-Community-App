//
//  OCProfileViewController.h
//  One Community
//
//  Created by Gustavo Romito on 6/1/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCBaseViewController.h"
#import <ParallaxBlur/JPBFloatingTextViewController.h>
#import <iOS_Slide_Menu/SlideNavigationController.h>

@interface OCProfileViewController : JPBFloatingTextViewController <UITableViewDataSource, UITableViewDelegate, SlideNavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *optionsTableView;
@property (nonatomic) NSIndexPath *lastIndex;

@end
