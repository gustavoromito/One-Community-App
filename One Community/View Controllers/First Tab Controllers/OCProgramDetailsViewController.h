//
//  OCProgramDetailsViewController.h
//  One Community
//
//  Created by Gustavo Romito on 6/3/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCBaseWithouMenuViewController.h"
#import <ASProgressPopUpView/ASProgressPopUpView.h>

@interface OCProgramDetailsViewController : OCBaseWithouMenuViewController

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet ASProgressPopUpView *progressBar;
@property (nonatomic) UIColor *color;

@end
