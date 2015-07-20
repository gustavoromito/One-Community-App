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
#import <RMMapper/NSUserDefaults+RMSaveCustomObject.h>

#import "UIColor+MHelper.h"

#define ARC4RANDOM_MAX 0x100000000
#define LOGGED_USER_KEY @"loggedUser"

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
//   [[SlideNavigationController sharedInstance] switchToViewController:viewController withCompletion:nil];
   [[SlideNavigationController sharedInstance] popAllAndSwitchToViewController:viewController withCompletion:nil];
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
   [[SlideNavigationController sharedInstance] popAllAndSwitchToViewController:vc withCompletion:nil];
}

- (void)pushAdminDashboards {
   [self pushAdminStoryboardWithViewController:@"adminDashboards"];
}

- (void)pushPeopleViewController {
   [self pushAdminStoryboardWithViewController:@"peopleViewController"];
}

- (void)pushMainStoryboardWithViewController:(NSString *)identifier {
   UIStoryboard *story = [UIStoryboard storyboardWithName:@"main" bundle:nil];
   UIViewController *vc = [story instantiateViewControllerWithIdentifier:identifier];
   [[SlideNavigationController sharedInstance] popAllAndSwitchToViewController:vc withCompletion:nil];
}

- (void)pushProgramsViewController {
   [self pushMainStoryboardWithViewController:@"programsViewController"];
}

- (void)pushScanViewController {
   [self pushMainStoryboardWithViewController:@"scanViewController"];
}

- (void)pushProfileViewController {
   [self pushMainStoryboardWithViewController:@"profileViewController"];
}

- (void)pushNewsViewController {
   [self genericStoryboardPushWithName:@"informative" animated:YES];
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

- (void)showAppropriateFailureMessageWithResponseObject:(id)responseObject{
   if (!responseObject) {
      [self showConnectionErrorAlert];
   }else{
      if ([responseObject valueForKey:@"message"]) {
         [self showAlertWithTitle:@"" andMessage:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"message"]]];
      }else{
         [self showGenericErrorWarning];
      }
   }
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

#pragma mark - Progress Bar Builder Helper
- (NSArray *)colorForHoursMade:(double)hours {
   if (hours < 5) {
      return [UIColor gradientRedColors];
   } else if (hours < 10) {
      return [UIColor gradientOrangeColors];
   } else if (hours < 20) {
      return [UIColor gradientGreenColors];
   } else if (hours < 40) {
      return [UIColor gradientBlueColors];
   } else if (hours < 70) {
      return [UIColor gradientPurpleColors];
   } else {
      return [UIColor gradientMagentaColors];
   }
}

- (double)percentageRelatedToWorkedHours:(double)hours {
   if (hours < 5) {
      return hours / 4.999999999999;
   } else if (hours < 10) {
      return hours / 9.999999999999;
   } else if (hours < 20) {
      return hours / 19.999999999999;
   } else if (hours < 40) {
      return hours / 39.999999999999;
   } else if (hours < 70) {
      return hours / 69.999999999999;
   } else {
      return hours / 100.0;
   }
}

- (NSRange)rangeForWorkedHours:(double)hours {
   if (hours < 5) {
      return NSMakeRange(0, 5);
   } else if (hours < 10) {
      return NSMakeRange(5, 5);
   } else if (hours < 20) {
      return NSMakeRange(10, 10);
   } else if (hours < 40) {
      return NSMakeRange(20, 20);
   } else if (hours < 70) {
      return NSMakeRange(40, 30);
   } else {
      return NSMakeRange(70, 30);
   }
}

#pragma mark - Number Generator
- (double)randomDoubleForMax:(double)maxValue {
   return ((double)arc4random() / ARC4RANDOM_MAX) * maxValue;
}

#pragma mark - User Logged
- (BOOL)isUserLoggedIn {
   NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
   return [defaults rm_customObjectForKey:LOGGED_USER_KEY];
}

- (User *)getLoggedUser {
   NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
   return [defaults rm_customObjectForKey:LOGGED_USER_KEY];
}

- (void)saveUserToDefaults:(User*)newUser {
   NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
   [defaults rm_setCustomObject:newUser forKey:LOGGED_USER_KEY];
}

@end
