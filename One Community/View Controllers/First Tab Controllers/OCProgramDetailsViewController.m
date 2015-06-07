//
//  OCProgramDetailsViewController.m
//  One Community
//
//  Created by Gustavo Romito on 6/3/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCProgramDetailsViewController.h"
#import "UIColor+MHelper.h"

#define ARC4RANDOM_MAX 0x100000000

@interface OCProgramDetailsViewController ()

@end

@implementation OCProgramDetailsViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   [self setupProgressBar];
   [self.navigationController.navigationItem setTitle:@"Program Details"];
   self.view.backgroundColor = _color;
   
   UIColor *translucentColor = [_color grayscale];
   _containerView.backgroundColor = [translucentColor colorWithAlphaComponent:0.85f];
   // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
   [super viewWillAppear:animated];
}

- (void) setupProgressBar {
   _progressBar.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:26];
   _progressBar.popUpViewAnimatedColors = @[_color];
   _progressBar.popUpViewCornerRadius = 16.0;
}

- (void)viewDidAppear:(BOOL)animated {
   [super viewDidAppear:animated];
   [_progressBar showPopUpViewAnimated:YES];
   double val = ((double)arc4random() / ARC4RANDOM_MAX) * (0.2f);
   [_progressBar setProgress:val animated:YES];
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
