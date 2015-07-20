//
//  OCInputViewController.m
//  One Community
//
//  Created by Gustavo Romito on 7/8/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCInputViewController.h"
#import <FlatUIKit/UIBarButtonItem+FlatUI.h>

@interface OCInputViewController ()

@end

@implementation OCInputViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   self.view.layer.cornerRadius = 5;
   self.view.layer.masksToBounds = YES;
   [_cancelBarButton configureFlatButtonWithColor:[UIColor colorWithWhite:1.0 alpha:0.8]
                                 highlightedColor:[[UIColor blueColor] colorWithAlphaComponent:0.8]
                                     cornerRadius:3.0f];
   // Do any additional setup after loading the view from its nib.
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
