//
//  OCProfileViewController.m
//  One Community
//
//  Created by Gustavo Romito on 6/1/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCProfileViewController.h"
#import <NSUserDefaults-AESEncryptor/NSUserDefaults+AESEncryptor.h>
#import <CocoaSecurity/CocoaSecurity.h>
#import "Barcode.h"

#define USER_ID_KEY @"userID"
#define AES_KEY [[NSBundle mainBundle] objectForInfoDictionaryKey:@"AESKey"]

@implementation OCProfileViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   NSString *code = @"gustavoromito";
   [[NSUserDefaults standardUserDefaults] removeObjectForAESKey:USER_ID_KEY];
   [[NSUserDefaults standardUserDefaults] setAESKey:AES_KEY];
   [[NSUserDefaults standardUserDefaults] encryptValue:code withKey:USER_ID_KEY];
   
   NSString *encryptedkey = [CocoaSecurity aesEncrypt:USER_ID_KEY
                                         key:[[NSUserDefaults standardUserDefaults] AESKey]].base64;
   
   NSString *encryptedValue = [[NSUserDefaults standardUserDefaults] objectForKey:encryptedkey];
   
   NSLog(@"encryptedkey: %@", encryptedkey);
   NSLog(@"encryptedValue: %@", encryptedValue);
   NSLog(@"value: %@", [[NSUserDefaults standardUserDefaults] decryptedValueForKey:USER_ID_KEY]);
   
   Barcode *barcode = [[Barcode alloc] init];
   
   [barcode setupQRCode:encryptedValue];
   _qrcodeImageView.image = barcode.qRBarcode;
   // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

@end
