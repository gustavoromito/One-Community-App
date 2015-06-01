//
//  OCSignInViewController.m
//  One Community
//
//  Created by Gustavo Romito on 6/1/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCSignInViewController.h"

@implementation OCSignInViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   [self.navigationController.navigationBar setHidden: YES];
   // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

- (IBAction)SignInTapped:(id)sender {
   //TOD: Validate login
   [self pushUserStoryboard];
}

- (IBAction)forgotPasswordTapped:(id)sender {
   //TODO
   [self showPendingWarningWithDescription:@"Add Forgot password Function."];
}
@end
