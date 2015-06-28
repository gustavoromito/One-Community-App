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
#import <UITableView_FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import <MGSwipeTableCell/MGSwipeButton.h>

#import "UIColor+MHelper.h"
#import <ObjectiveSugar/ObjectiveSugar.h>

#define HEADER_SIZE 20.0f
#define FOOTER_SIZE 42.0f
#define RECORD_CELL_SIZE 66.0f
#define PROGRESS_CELL_SIZE 30.0f
#define NEW_RECORD_CELL_SIZE 150.0f

#define FIRST_CELL_IDENTIFIER @"progressBarCell"
#define HEADER_CELL_IDENTIFIER @"headerCell"
#define FOOTER_CELL_IDENTIFIER @"footerCell"
#define RECORD_CELL_IDENTIFIER @"recordCell"
#define NEW_RECORD_CELL_IDENTIFIER @"newRecordCell"

@interface OCDashboardViewController () {
   NSArray *weeks;
   NSMutableArray *newRowForSection;
}

@end

@implementation OCDashboardViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   self.navigationController.navigationItem.title = @"Dashboard";
   weeks = @[@{@"week": @"06/04",
               @"logs": @[@{@"hours": @8,
                            @"categoryName": @"Funding & Partnership Building",
                            @"description": @"Some sample description"},
                          @{@"hours": @28,
                            @"categoryName": @"Marketing & Promotion",
                            @"description": @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed dapibus lorem. Sed porta rhoncus libero, in interdum lacus consectetur at. Pellentesque et nibh felis. Sed vitae mauris arcu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Etiam luctus leo sit amet justo posuere, a cursus dolor sodales. Duis nec turpis et ipsum hendrerit eleifend nec ut nunc. Duis lacus lacus, ornare in erat ut, blandit porta tortor. Vestibulum eu fermentum massa, at fermentum erat. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris iaculis mauris ac lectus cursus, sit amet hendrerit nunc venenatis. Nunc sollicitudin dui eget quam faucibus sagittis."}]},
             @{@"week": @"06/04",
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
   
   newRowForSection = [[NSMutableArray alloc] initWithCapacity:weeks.count];
   [weeks each:^(id object) {
      [newRowForSection addObject:[NSNumber numberWithBool:NO]];
   }];
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
#pragma mark Cell Initialization
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   OCCustomTableViewCell *cell;
   cell = (OCCustomTableViewCell *)[self buildCellWithIdentifier:[self getIdentifierForIndexPath:indexPath]
                                                       andAction:nil];
   NSInteger totalRows = [[[weeks objectAtIndex:indexPath.section] objectForKey:@"logs"] count] + 2;
   [cell setProgressBarColor:[self colorForHoursMade:10.5]];
   if (indexPath.row > 0 && indexPath.row < totalRows - 1) {
      NSArray *logs = [[weeks objectAtIndex:indexPath.section] objectForKey:@"logs"];
      NSDictionary *tempDic = [logs objectAtIndex:indexPath.row - 1];
      cell.mainText.text = [NSString stringWithFormat:@"%@hrs", [tempDic valueForKey:@"hours"]];
      cell.subText.text = [tempDic valueForKey:@"categoryName"];
      cell.extraText.text = [tempDic valueForKey:@"description"];
      
      cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"Delete"
                                           backgroundColor:[UIColor redColor]
                                                  callback:^BOOL(MGSwipeTableCell *sender) {
                              NSLog(@"Convenience callback for swipe buttons!");
                              return true;
                            }],
                            [MGSwipeButton buttonWithTitle:@"Edit"
                                           backgroundColor:[UIColor lightGrayColor]
                                                  callback:^BOOL(MGSwipeTableCell *sender) {
                               NSLog(@"Convenience callback for swipe buttons!");
                               return true;
                            }]];
   }
   return cell;
}

- (NSString *)getIdentifierForIndexPath:(NSIndexPath *)indexPath {
   NSInteger totalRows = [[[weeks objectAtIndex:indexPath.section] objectForKey:@"logs"] count] + 2;
   if (indexPath.row == 0) { return FIRST_CELL_IDENTIFIER;
   } else if (indexPath.row < totalRows - 1) { return RECORD_CELL_IDENTIFIER;
   } else {
      return [[newRowForSection objectAtIndex:indexPath.section] boolValue] == YES ? NEW_RECORD_CELL_IDENTIFIER : FOOTER_CELL_IDENTIFIER;
   }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [[[weeks objectAtIndex:section] objectForKey:@"logs"] count] + 2;
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
//   return (indexPath.row == 0) ? PROGRESS_CELL_SIZE : RECORD_CELL_SIZE;
   NSInteger totalRows = [[[weeks objectAtIndex:indexPath.section] objectForKey:@"logs"] count] + 2;
   if (indexPath.row == 0) {
      return PROGRESS_CELL_SIZE;
   } else if (indexPath.row == totalRows - 1) {
      return [[newRowForSection objectAtIndex:indexPath.section] boolValue] == YES ? NEW_RECORD_CELL_SIZE : FOOTER_SIZE;
   }
   return [tableView fd_heightForCellWithIdentifier:RECORD_CELL_IDENTIFIER cacheByIndexPath:indexPath configuration:^(id cell) {
      // configurations
      NSArray *logs = [[weeks objectAtIndex:indexPath.section] objectForKey:@"logs"];
      NSDictionary *tempDic = [logs objectAtIndex:indexPath.row - 1];
      ((OCCustomTableViewCell *)cell).extraText.text = [tempDic valueForKey:@"description"];
   }];
}

#pragma mark Footer Initialization
-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section{
   return [[UIView alloc] initWithFrame:CGRectZero];
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


- (IBAction)addRowToSection:(id)sender {
   NSIndexPath *indexPath = [self getButtonIndexPath:sender];
   [_tableView beginUpdates];
   [newRowForSection replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:YES]];
   [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
   [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
   [_tableView endUpdates];
   [_tableView reloadData];
}

-(NSIndexPath *) getButtonIndexPath:(UIButton *) button
{
   CGRect buttonFrame = [button convertRect:button.bounds toView:_tableView];
   return [_tableView indexPathForRowAtPoint:buttonFrame.origin];
}
@end