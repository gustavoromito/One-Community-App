//
//  OCScanViewController.m
//  HG Network
//
//  Created by Gustavo Romito on 7/14/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCScanViewController.h"

@interface OCScanViewController () {
   QRCodeReaderViewController *_reader;
}

@end

@implementation OCScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scanTapped:(id)sender {
   NSArray *types = @[AVMetadataObjectTypeQRCode];
   _reader        = [QRCodeReaderViewController readerWithMetadataObjectTypes:types];
   
   // Set the presentation style
   _reader.modalPresentationStyle = UIModalPresentationFormSheet;
   
   // Using delegate methods
   _reader.delegate = self;
   
   // Or by using blocks
   __weak typeof(self) weakSelf = self;
   [_reader setCompletionWithBlock:^(NSString *resultAsString) {
      [weakSelf dismissViewControllerAnimated:YES completion:^{
         weakSelf.contentTextView.text = resultAsString;
      }];
   }];
   
   [self presentViewController:_reader animated:YES completion:NULL];
}

@end
