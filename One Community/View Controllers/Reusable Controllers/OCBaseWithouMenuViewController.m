//
//  OCBaseWithouMenuViewController.m
//  One Community
//
//  Created by Gustavo Romito on 6/7/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCBaseWithouMenuViewController.h"

@interface OCBaseWithouMenuViewController ()

@end

@implementation OCBaseWithouMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - iOS-Slide-Menu Delegates
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu {
   return NO;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu {
   return NO;
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
