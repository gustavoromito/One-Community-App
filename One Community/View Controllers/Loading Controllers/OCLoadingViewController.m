//
//  OCLoadingViewController.m
//  One Community
//
//  Created by Gustavo Romito on 6/2/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCLoadingViewController.h"
#import <HexColors/HexColors.h>

#import <SKSplashView/SKSplashIcon.h>

#define LOADING_TIME 2.0f

@interface OCLoadingViewController () {
   SKSplashView *splashView;
   UIActivityIndicatorView *spinner;
}
@end

@implementation OCLoadingViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   [self addSplashScreen];
   [self.navigationController.navigationBar setHidden:YES];
   // Do any additional setup after loading the view.
}

-(void)addSplashScreen {
   UIImage *treeIcon = [UIImage imageNamed:@"tree_icon"];
   UIColor *backColor = [UIColor colorWithHexString:COLOR_HEX];
   
   //The SplashView can be initialized with a variety of animation types and backgrounds. See customizability for more.
   SKSplashIcon *splashIcon;
   splashIcon = [[SKSplashIcon alloc] initWithImage:treeIcon animationType:SKIconAnimationTypeBounce];
   
   splashView = [[SKSplashView alloc] initWithSplashIcon:splashIcon backgroundColor:backColor animationType:SKSplashAnimationTypeZoom];
   splashView.delegate = self;
   
   splashView.animationDuration = 2.0f; //Set the animation duration (Default: 1s)
   
   spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
   spinner.frame = CGRectMake(self.view.frame.size.width / 2 - spinner.frame.size.width / 2,
                              self.view.frame.size.height / 2 + 100,
                              spinner.frame.size.width,
                              spinner.frame.size.height);
   
   [self.view addSubview:splashView]; //Add the splash view to your current view
   
   [self.view addSubview:spinner];
   
   [spinner startAnimating];
   [self simulateLoading];
}

- (void)simulateLoading {
   double delayInSeconds = LOADING_TIME;
   dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
   dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      [splashView startAnimation]; //Call this method to start the splash animation
   });
}


- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate methods

- (void) splashView:(SKSplashView *)splashView didBeginAnimatingWithDuration:(float)duration {
   [spinner setHidden:YES];
   //To start activity animation when splash animation starts
}

- (void) splashViewDidEndAnimating:(SKSplashView *)splashView
{
   [self pushNewsAndUpdatesAnimated:NO];
   //To stop activity animation when splash animation ends
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
