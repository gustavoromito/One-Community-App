//
//  MBaseViewController.h
//  Moblyboy
//
//  Created by Gustavo Romito on 2/23/15.
//  Copyright (c) 2015 MKM Brasil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <iOS-Slide-Menu/SlideNavigationController.h>

#define COLOR_HEX @"98CE1E"

@interface OCBaseViewController : UIViewController <SlideNavigationControllerDelegate>

#pragma mark - MBProgressHUD Helpers
- (void(^)(void))showHUDWithMessage:(NSString *)message andCancellableRequestPath:(NSString *)requestPath;
- (void)showHUDwithTitle:(NSString*)title andDetail:(NSString*)detail forSeconds:(CGFloat)seconds thenExecute:(void(^)(void))afterBlock;
- (MBProgressHUD *)showHUDwithTitle:(NSString*)title andDetail:(NSString*)detail;

#pragma mark - Placeholder Warnings & Alert View Helpers
- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message;
- (void)showErrorWarningWithDescription:(NSString *)description;
- (void)showConnectionErrorAlert;
- (void)showCancelledOperationAlert;
- (void)showPendingWarningWithDescription:(NSString *)description;
- (void)showGenericErrorWarning;

#pragma mark - Navigation Helpers
- (void)pushUserStoryboardAnimated:(BOOL)animated;
- (void)pushSignInSignUpStoryboardAnimated:(BOOL)animated;
- (void)pushNewsAndUpdatesAnimated:(BOOL)animated;
- (void)pushAdminDashboards;
- (void)pushPeopleViewController;

#pragma mark - Image Helper
- (UIImage *)getImageFromURL:(NSString*)path;

#pragma mark - Progress Bar Builder Helper
- (NSArray *)colorForHoursMade:(double)hours;
- (double)percentageRelatedToWorkedHours:(double)hours;
- (NSRange)rangeForWorkedHours:(double)hours;
   
#pragma mark - Number Generator
- (double)randomDoubleForMax:(double)maxValue;

@end
