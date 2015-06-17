//
//  MBaseViewController.m
//  Moblyboy
//
//  Created by Gustavo Romito on 2/23/15.
//  Copyright (c) 2015 MKM Brasil. All rights reserved.
//

#import "OCBaseViewController.h"
#import "OCLeftMenuTableViewController.h"
#import <iOS-Slide-Menu/SlideNavigationController.h>
#import <iOS-Slide-Menu/SlideNavigationContorllerAnimatorSlide.h>

@interface OCBaseViewController ()

@end

@implementation OCBaseViewController

- (void)viewDidLoad {
   [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MBProgressHUD Helpers
- (void(^)(void))showHUDWithMessage:(NSString *)message andCancellableRequestPath:(NSString *)requestPath {
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   hud.labelText = message;
   hud.detailsLabelText  = @"Segure para cancelar.";
   
   return ^{[hud hide:YES];}; //use void(^hide)(void) property to store it.
}

- (void)showHUDwithTitle:(NSString*)title andDetail:(NSString*)detail forSeconds:(CGFloat)seconds thenExecute:(void(^)(void))afterBlock {
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   hud.labelText = title;
   hud.detailsLabelText = detail;
   [hud hide:YES afterDelay:seconds];
   
   if (afterBlock != nil) {
      double delayInSeconds = seconds;
      dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
      dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
         afterBlock();
      });
   }
}

- (MBProgressHUD *)showHUDwithTitle:(NSString*)title andDetail:(NSString*)detail{
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   hud.labelText = title;
   hud.detailsLabelText = detail;
   return hud;
}

#pragma mark - Navigation Helpers

- (void)genericStoryboardPushWithName:(NSString *)storyboardName animated:(BOOL)animated{
   UIStoryboard *story = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
   UIViewController *viewController = [story instantiateInitialViewController];
   [self.navigationController pushViewController:viewController animated:animated];
}

- (void)pushUserStoryboardAnimated:(BOOL)animated{
   [self genericStoryboardPushWithName:@"main" animated:animated];
}

- (void)pushSignInSignUpStoryboardAnimated:(BOOL)animated {
//   [self genericStoryboardPushWithName:@"login" animated:animated];
   UIStoryboard *story = [UIStoryboard storyboardWithName:@"login" bundle:nil];
   UIViewController *viewController = [story instantiateInitialViewController];
   [self presentViewController:viewController animated:YES completion:nil];
   
}

- (void)pushNewsAndUpdatesAnimated:(BOOL)animated {
   [self genericStoryboardPushWithName:@"informative" animated:animated];
}

- (void)pushAdminStoryboardWithViewController:(NSString *)identifier {
   UIStoryboard *story = [UIStoryboard storyboardWithName:@"admin" bundle:nil];
   UIViewController *vc = [story instantiateViewControllerWithIdentifier:identifier];
   [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc withCompletion:nil];
}

- (void)pushAdminDashboards {
   [self pushAdminStoryboardWithViewController:@"adminDashboards"];
}

#pragma mark - Placeholder Warnings & Alert View Helpers
- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
   [[[UIAlertView alloc] initWithTitle:title
                               message:message
                              delegate:nil
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil] show];
}

- (void)showErrorWarningWithDescription:(NSString *)description {
   [[[UIAlertView alloc] initWithTitle:@"Error founded!"
                               message:description
                              delegate:nil cancelButtonTitle:@"OK"
                     otherButtonTitles:nil] show];
}

- (void)showConnectionErrorAlert {
   [[[UIAlertView alloc] initWithTitle:@"Connection Problem!"
                               message:@"We could not reach our servers."
                              delegate:nil cancelButtonTitle:@"OK"
                     otherButtonTitles:nil] show];
}

- (void)showCancelledOperationAlert {
   [[[UIAlertView alloc] initWithTitle:nil
                               message:@"Successfuly canceled operation."
                              delegate:nil cancelButtonTitle:@"OK"
                     otherButtonTitles:nil] show];
}

- (void)showPendingWarningWithDescription:(NSString *)description {
   [[[UIAlertView alloc] initWithTitle:@"Pending feature!"
                               message:description
                              delegate:nil cancelButtonTitle:@"OK"
                     otherButtonTitles:nil] show];
}

- (void)showGenericErrorWarning {
   [[[UIAlertView alloc] initWithTitle:@"Unexpected Error Founded!"
                               message:@"Please, report this to the develop team."
                              delegate:nil cancelButtonTitle:@"OK"
                     otherButtonTitles:nil] show];
}

#pragma mark - IOS Slide Menu Delegate
- (BOOL)slideNavigationControllerShouldDisplayRightMenu {
   return NO;
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu {
   return YES;
}

#pragma mark - Image Helper
- (UIImage *)getImageFromURL:(NSString*)path {
   NSURL *url = [NSURL URLWithString:path];
   NSData *data = [NSData dataWithContentsOfURL:url];
   return [[UIImage alloc] initWithData:data];
}

@end
