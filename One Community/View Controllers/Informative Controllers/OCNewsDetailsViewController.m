//
//  OCNewsDetailsViewController.m
//  One Community
//
//  Created by Gustavo Romito on 7/13/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCNewsDetailsViewController.h"

@interface OCNewsDetailsViewController ()

@end

@implementation OCNewsDetailsViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   NSURLRequest *requestObj = [NSURLRequest requestWithURL:_outsideUrl];
   [_webView loadRequest:requestObj];
   _webView.delegate = self;
   // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
   UIApplication* app = [UIApplication sharedApplication];
   app.networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
   UIApplication* app = [UIApplication sharedApplication];
   app.networkActivityIndicatorVisible = NO;
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
