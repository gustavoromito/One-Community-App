//
//  OCNewsDetailsViewController.h
//  One Community
//
//  Created by Gustavo Romito on 7/13/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCBaseWithouMenuViewController.h"

@interface OCNewsDetailsViewController : OCBaseWithouMenuViewController <UIWebViewDelegate>

@property (strong, nonatomic) NSURL *outsideUrl;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
