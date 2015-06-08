//
//  OCInformativeViewController.m
//  One Community
//
//  Created by Gustavo Romito on 6/8/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCInformativeViewController.h"
#import "OCCustomTableViewCell.h"
#import "UIImage+OCHelper.h"

#define UPDATE_CELL_IDENTIFIER @"updateCell"

@interface OCInformativeViewController () {
   NSArray *news;
}

@end

@implementation OCInformativeViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   [self.navigationController.navigationBar setHidden:NO];
   [self.navigationItem setHidesBackButton:YES];
   news = @[@{@"title": @"One Community Welcomes Fernando Bitencourt to the Structural Design Team",
              @"date" : @"12/12/1994",
              @"coverImageUrl" : @"http://www.onecommunityglobal.org/wp-content/uploads/2015/06/Fernando-Campos-Bitencourt-640.jpg"},
            @{@"title": @"One Community Welcomes Adolpho Maia to the Mechanical Engineering Team",
              @"date" : @"12/12/1994",
              @"coverImageUrl" : @"http://www.onecommunityglobal.org/wp-content/uploads/2015/06/Adolpho-Maia-640.jpg"},
            @{@"title": @"One Community Welcomes Joao Bernardes to the Hydraulics Team",
              @"date" : @"12/12/1994",
              @"coverImageUrl" : @"http://www.onecommunityglobal.org/wp-content/uploads/2015/06/Joao-Paulo-Bernardes-640.jpg"},
            @{@"title": @"One Community Welcomes Renata Maehara to the Design Team",
              @"date" : @"12/12/1994",
              @"coverImageUrl" : @"http://www.onecommunityglobal.org/wp-content/uploads/2015/06/Renata-Maehara-640-size.jpg"},
            ];
   
   
   // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
#pragma mark Cell Initialization
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   OCCustomTableViewCell *cell;
   cell = (OCCustomTableViewCell *)[self buildCellWithIdentifier:UPDATE_CELL_IDENTIFIER andAction:nil];
   NSDictionary *tempDic = [news objectAtIndex:indexPath.section];
   cell.mainText.text = [tempDic valueForKey:@"title"];
   
   NSDateFormatter *inFormat = [[NSDateFormatter alloc] init];
   NSDateFormatter *outFormat = [[NSDateFormatter alloc] init];
   [inFormat setDateFormat:@"MM/dd/yyyy"];
   [outFormat setDateFormat:@"MMM dd, yyyy"];
   
   NSDate *date = [inFormat dateFromString:[tempDic valueForKey:@"date"]];
   NSString *dateStringFormatted = [outFormat stringFromDate:date];
   
   cell.subText.text = [NSString stringWithFormat:@"Posted on %@", dateStringFormatted];
   cell.leftIcon.image = [self getImageFromURL:[tempDic valueForKey:@"coverImageUrl"]];
   return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return 1;
}

#pragma mark Header Initialization
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return [news count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return 0.01f;
}

#pragma mark Footer Initialization
-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section{
   return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   return 10.0f;
}

#pragma mark Header/Footer Helpers
- (UITableViewCell *)buildCellWithIdentifier:(NSString *)identifier andAction:(SEL)action {
   OCCustomTableViewCell *cell = (OCCustomTableViewCell *)[_tableView dequeueReusableCellWithIdentifier:identifier];
   if (cell == nil) cell = [[OCCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
   return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
