//
//  OCInputViewController.h
//  One Community
//
//  Created by Gustavo Romito on 7/8/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCInputViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *inputTextView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancelBarButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sendBarButton;

@end
