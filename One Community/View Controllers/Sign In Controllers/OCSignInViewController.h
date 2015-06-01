//
//  OCSignInViewController.h
//  One Community
//
//  Created by Gustavo Romito on 6/1/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCBaseViewController.h"

@interface OCSignInViewController : OCBaseViewController
@property (strong, nonatomic) IBOutlet UITextField *userIdTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)SignInTapped:(id)sender;
- (IBAction)forgotPasswordTapped:(id)sender;
@end
