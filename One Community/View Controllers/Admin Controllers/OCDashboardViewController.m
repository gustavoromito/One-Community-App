//
//  OCDashboardViewController.m
//  One Community
//
//  Created by Gustavo Romito on 6/16/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCDashboardViewController.h"
#import "OCCustomTableViewCell.h"
#import <HexColors/HexColor.h>

#define FIRST_CELL_IDENTIFIER @"progressBarCell"
#define HEADER_CELL_IDENTIFIER @"headerCell"
#define RECORD_CELL_IDENTIFIER @"recordCell"
#define HEADER_SIZE 20.0f
#define RECORD_CELL_SIZE 66.0f
#define PROGRESS_CELL_SIZE 30.0f

#define GREEN_COLORS @[[UIColor colorWithHexString:@"a7ce1e"], [UIColor colorWithHexString:COLOR_HEX], [UIColor colorWithHexString:@"89ce1e"], [UIColor colorWithHexString:@"7bce1e"], [UIColor colorWithHexString:@"6cce1e"]]
#define RED_COLORS @[[UIColor colorWithHexString:@"ff002b"], [UIColor colorWithHexString:@"ff0015"], [UIColor colorWithHexString:@"ff0000"], [UIColor colorWithHexString:@"ff1500"], [UIColor colorWithHexString:@"ff2b00"]]

@interface OCDashboardViewController () {
   NSArray *weeks;
}

@end

@implementation OCDashboardViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   weeks = @[@{@"week": @"06/04",
               @"logs": @[@{@"hours": @8,
                            @"categoryName": @"Funding & Partnership Building",
                            @"description": @"Some sample description"},
                          @{@"hours": @28,
                            @"categoryName": @"Marketing & Promotion",
                            @"description": @"Some sample description"}]},
             @{@"week": @"06/11",
               @"logs": @[@{@"hours": @10,
                            @"categoryName": @"Infrastructure & Planning",
                            @"description": @"Some sample description"},
                          @{@"hours": @2,
                            @"categoryName": @"Everything else",
                            @"description": @"Some sample description"},
                          @{@"hours": @8,
                            @"categoryName": @"Funding & Partnership Building",
                            @"description": @"Some sample description"},
                          @{@"hours": @28,
                            @"categoryName": @"Marketing & Promotion",
                            @"description": @"Some sample description"}]}];
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
   NSString *identifier = (indexPath.row == 0) ? FIRST_CELL_IDENTIFIER : RECORD_CELL_IDENTIFIER;
   cell = (OCCustomTableViewCell *)[self buildCellWithIdentifier:identifier andAction:nil];
   cell.progressBar.type = YLProgressBarTypeFlat;
   cell.progressBar.progressBarInset = 0.0f;
   cell.progressBar.behavior = YLProgressBarBehaviorIndeterminate;
   cell.progressBar.stripesOrientation = YLProgressBarStripesOrientationVertical;
   cell.progressBar.progressTintColors = indexPath.section == 0 ? RED_COLORS : GREEN_COLORS;
   return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [[[weeks objectAtIndex:section] objectForKey:@"logs"] count] + 1;
}

#pragma mark Header Initialization
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   OCCustomTableViewCell *cell;
   cell = (OCCustomTableViewCell *)[self buildCellWithIdentifier:HEADER_CELL_IDENTIFIER andAction:nil];
   if (section != 0) {
      cell.backgroundColor = [UIColor darkGrayColor];
      cell.backgroundView.backgroundColor = [UIColor darkGrayColor];
   }
   return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return [weeks count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return HEADER_SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   return (indexPath.row == 0) ? PROGRESS_CELL_SIZE : RECORD_CELL_SIZE;
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
