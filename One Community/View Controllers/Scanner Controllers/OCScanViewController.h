//
//  OCScanViewController.h
//  HG Network
//
//  Created by Gustavo Romito on 7/14/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCBaseViewController.h"
#import <QRCodeReaderViewController/QRCodeReaderViewController.h>
#import <QRCodeReaderViewController/QRCodeReaderDelegate.h>

@interface OCScanViewController : OCBaseViewController <QRCodeReaderDelegate>
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;

- (IBAction)scanTapped:(id)sender;
@end
