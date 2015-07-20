//
//  OCSignInViewController.m
//  One Community
//
//  Created by Gustavo Romito on 6/1/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCSignInViewController.h"
#import "User.h"

@implementation OCSignInViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   [self.navigationController.navigationBar setHidden: YES];
//    Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

- (IBAction)SignInTapped:(id)sender {
   //TODO: Validate login
   NSDictionary *dic = @{@"id" : @1,
                         @"login" : @"gustavoromito",
                         @"type_id" : @1,
                         @"first_name" : @"Gustavo",
                         @"last_name" : @"Romito Nogueira",
                         @"dob" : @"12/12/1994",
                         @"week_hrs" : @40,
                         @"extra_hrs" : @0,
                         @"tel" : @"111 111 1111",
                         @"mail" : @"guromito@gmail.com"};
   User *newUser = [[User alloc] initWithDictionary:dic];
   [self saveUserToDefaults:newUser];
   [[NSNotificationCenter defaultCenter] postNotificationName:@"userSignedIn" object:nil];
   [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)forgotPasswordTapped:(id)sender {
   //TODO
   [self showPendingWarningWithDescription:@"Add Forgot password Function."];
}

- (IBAction)cancelTapped:(id)sender {
   [self dismissViewControllerAnimated:YES completion:nil];
}

@end

