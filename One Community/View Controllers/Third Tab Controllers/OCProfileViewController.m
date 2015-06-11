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

#import "OCCustomTableViewCell.h"

#define USER_ID_KEY @"userID"
#define AES_KEY [[NSBundle mainBundle] objectForInfoDictionaryKey:@"AESKey"]
#define OPTION_CELL_IDENTIFIER @"optionCell"
#define HEADER_CELL_IDENTIFIER @"headerCell"
#define FOOTER_CELL_IDENTIFIER @"footerCell"
#define HEADER_HEIGHT 25.0f
#define FOOTER_HEIGHT 80.0f
#define QRCODE_IMAGE_INSET 50.0f

@interface OCProfileViewController (){
   NSArray *sections;
   NSArray *options;
   NSArray *reports;
}

@end

@implementation OCProfileViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   [self.navigationController.navigationBar setHidden:YES];
   [self qrcodeSetup];
   options = @[@"Public", @"Private"];
   reports = @[@"Report 1", @"Report 2", @"Report 3"];
   sections = @[options, reports];
   // Do any additional setup after loading the view.
}

- (void)qrcodeSetup {
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
//   _qrcodeImageView.image = barcode.qRBarcode;
   [self.view setBackgroundColor:[UIColor whiteColor]];
   
   [self setHeaderImage:[self paddedImageFrom:barcode.qRBarcode]];
   [self setLabelBackgroundGradientColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.3f]];
   [self setTitleText:@"gustavoromito"];
   [self setSubtitleText:@"is logged in!"];
}

- (UIImage *)paddedImageFrom:(UIImage *)imageName {
   CGFloat deviceWidth = [[UIScreen mainScreen] bounds].size.width;
   CGSize size = CGSizeMake(imageName.size.width + QRCODE_IMAGE_INSET, imageName.size.height + QRCODE_IMAGE_INSET);
   UIGraphicsBeginImageContextWithOptions(size, YES, 0);
   [[UIColor whiteColor] setFill];
   UIRectFill(CGRectMake(0, 0, size.width, size.height));
   UIImage *blankBackImage = UIGraphicsGetImageFromCurrentImageContext();
   UIGraphicsEndImageContext();
   
   CGSize newSize = CGSizeMake(deviceWidth, self.headerHeight);
   UIGraphicsBeginImageContext( newSize );
   
   // Use existing opacity as is
   [blankBackImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height) blendMode:kCGBlendModeNormal alpha:0.0];
   
   CGSize qrcodeSize = CGSizeMake(imageName.size.width, imageName.size.height);
   [imageName drawInRect:CGRectMake(deviceWidth / 2 - qrcodeSize.width / 2,
                                    0.0f,
                                    qrcodeSize.width,
                                    qrcodeSize.height)];
   
   UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
   
   UIGraphicsEndImageContext();
   return newImage;
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
#pragma mark Cell Initialization
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   OCCustomTableViewCell *cell;
   cell = (OCCustomTableViewCell *)[self buildCellWithIdentifier:OPTION_CELL_IDENTIFIER andAction:nil];
   [cell.mainText setText:[[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
   switch (indexPath.section) {
      case 0:
         if ([indexPath compare:_lastIndex] == NSOrderedSame) { cell.accessoryType = UITableViewCellAccessoryCheckmark;
         } else { cell.accessoryType = UITableViewCellAccessoryNone; }
         break;
      case 1:
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         break;
      default:
         break;
   }
   
   return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [[sections objectAtIndex:section] count];
}

#pragma mark Header Initialization
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   OCCustomTableViewCell *cell = (OCCustomTableViewCell *)[self buildCellWithIdentifier:HEADER_CELL_IDENTIFIER andAction:nil];
   switch (section) {
      case 0:
         [cell.mainText setText:@"Public Mode"];
         break;
      case 1:
         [cell.mainText setText:@"Reports"];
         break;
      default:
         break;
   }
   return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return [sections count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return HEADER_HEIGHT;
}

#pragma mark Footer Initialization
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
   if (section == 0) {
         OCCustomTableViewCell *cell = (OCCustomTableViewCell *)[self buildCellWithIdentifier:FOOTER_CELL_IDENTIFIER andAction:nil];
      return cell;
   } else {
      return nil;
   }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   return section == 0 ? FOOTER_HEIGHT : 5.0f;
}

#pragma mark Header/Footer Helpers
- (UITableViewCell *)buildCellWithIdentifier:(NSString *)identifier andAction:(SEL)action {
   OCCustomTableViewCell *cell = (OCCustomTableViewCell *)[_optionsTableView dequeueReusableCellWithIdentifier:identifier];
   if (cell == nil) cell = [[OCCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
   return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   _lastIndex = indexPath.section == 0 ?  indexPath : _lastIndex;
   [tableView reloadData];
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
