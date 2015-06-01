//
//  MBaseViewController.m
//  Moblyboy
//
//  Created by Gustavo Romito on 2/23/15.
//  Copyright (c) 2015 MKM Brasil. All rights reserved.
//

#import "MBaseViewController.h"

@interface MBaseViewController ()

@end

@implementation MBaseViewController

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

- (void)genericStoryboardPushWithName:(NSString *)storyboardName {
   UIStoryboard *story = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
   UIViewController *viewController = [story instantiateInitialViewController];
   [[MSlideNavigationController sharedInstance] pushViewController:viewController animated:YES];
}

- (void)pushUserStoryboard {
   [self genericStoryboardPushWithName:@"MUserSB"];
}

- (void)pushSignInSignUpStoryboard {
   [self genericStoryboardPushWithName:@"MSignInSignUp"];
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
   [[[UIAlertView alloc] initWithTitle:@"Erro encontrado!"
                               message:description
                              delegate:nil cancelButtonTitle:@"OK"
                     otherButtonTitles:nil] show];
}

- (void)showConnectionErrorAlert {
   [[[UIAlertView alloc] initWithTitle:@"Falha de conexão!"
                               message:@"Não foi possível estabelecer uma conexão com o servidor."
                              delegate:nil cancelButtonTitle:@"OK"
                     otherButtonTitles:nil] show];
}

- (void)showCancelledOperationAlert {
   [[[UIAlertView alloc] initWithTitle:nil
                               message:@"Operação cancelada com sucesso."
                              delegate:nil cancelButtonTitle:@"OK"
                     otherButtonTitles:nil] show];
}

- (void)showPendingWarningWithDescription:(NSString *)description {
   [[[UIAlertView alloc] initWithTitle:@"Funcionalidade pendente!"
                               message:description
                              delegate:nil cancelButtonTitle:@"OK"
                     otherButtonTitles:nil] show];
}

- (void)showGenericErrorWarning {
   [[[UIAlertView alloc] initWithTitle:@"Erro inesperado encontrado!"
                               message:@"Por favor, reporte este erro para a equipe de desenvolvimento!"
                              delegate:nil cancelButtonTitle:@"OK"
                     otherButtonTitles:nil] show];
}

#pragma mark - iOS-Slide-Menu Delegates & Helpers
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu {
   return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu {
   return YES;
}

@end
