//
//  OCDashboardViewController.m
//  One Community
//
//  Created by Gustavo Romito on 6/16/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCDashboardViewController.h"
#import "OCCustomTableViewCell.h"
#import <HexColors/HexColors.h>
#import <UITableView_FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import <MGSwipeTableCell/MGSwipeButton.h>
#import "OCNewActivityViewController.h"

#import "OCHTTPClient.h"
#import "Task.h"
#import "Subtask.h"
#import "Week.h"

#import "UIColor+MHelper.h"
#import <ObjectiveSugar/ObjectiveSugar.h>
#import <REComposeViewController/REComposeViewController.h>

#define HEADER_SIZE 20.0f
#define FOOTER_SIZE 42.0f
#define RECORD_CELL_SIZE 66.0f
#define PROGRESS_CELL_SIZE 30.0f

#define FIRST_CELL_IDENTIFIER @"progressBarCell"
#define HEADER_CELL_IDENTIFIER @"headerCell"
#define FOOTER_CELL_IDENTIFIER @"footerCell"
#define TASK_CELL_IDENTIFIER @"taskCell"
#define SUB_TASK_CELL_IDENTIFIER @"subTaskCell"

@interface OCDashboardViewController () {
   NSMutableArray *weeks;
   NSMutableArray *sections;
   NSNumber *loadDataForUserID;
}

@end

@implementation OCDashboardViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   [self initialSetup];
   [self fetchAPIData];
}

- (void)initialSetup {
   self.navigationItem.title = (_outsideUser == nil) ? @"Dashboard" : _outsideUser.name;
   // Do any additional setup after loading the view.
   weeks = [[NSMutableArray alloc] init];
   sections = [[NSMutableArray alloc] init];
   self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
   loadDataForUserID = (_outsideUser == nil) ?  ((User*)[self getLoggedUser]).user_id : _outsideUser.user_id;
}

- (void)Back {
   [[SlideNavigationController sharedInstance] popViewControllerAnimated:YES];
}

- (void)fetchAPIData {
   NSString *requestPath = @"users/workedHours?user_id=1";
   MBProgressHUD *hud = [self showHUDwithTitle:@"Please, wait..." andDetail:@"loading data from API."];
   [self.view bringSubviewToFront:hud];
   OCHTTPClient *client = [OCHTTPClient privateClient];
   [client GET:requestPath
    parameters:@{@"user_id": loadDataForUserID}
       success:^(AFHTTPRequestOperation *operation, id responseObject) {
          [hud hide:YES];
          if ([[responseObject valueForKey:@"success"] intValue] == 0) {
             [self showAlertWithTitle:@"Alert:" andMessage:[responseObject valueForKey:@"message"]];
          }else{
             [self buildObjects:responseObject];
             [_tableView reloadData];
          }
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          [hud hide:YES];
          [self showAppropriateFailureMessageWithResponseObject:operation.responseObject];
       }];
}

- (void)buildObjects:(NSDictionary *)responseObject {
   NSArray *ws = [responseObject objectForKey:@"weeks"];
   [ws each:^(id week) {
      Week *newWeek = [[Week alloc] initWithWeekNumber:[week valueForKey:@"weekNumber"]];
      __block double totalHours = 0;
      [[week objectForKey:@"tasks"] each:^(id task) {
         Task *newTask = [[Task alloc] initWithDictionary:[task firstObject]];
         [task each:^(id subTask) {
            Subtask *newSubTask = [[Subtask alloc] initWithDictionary:subTask];
            totalHours += newSubTask.time.doubleValue;
            [newTask.subTasks addObject:newSubTask];
         }];
         [newWeek.tasks addObject:newTask];
      }];
      newWeek.totalHours = [NSNumber numberWithDouble:totalHours];
      [weeks addObject:newWeek];
   }];
   [weeks each:^(Week *week) {
      [sections addObject:week.tasks];
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
   NSInteger totalRows = [[sections objectAtIndex:indexPath.section] count] + 2;
   [cell setProgressBarColor:[self colorForHoursMade:10.5]];
   if (indexPath.row > 0 && indexPath.row < totalRows - 1) {
      NSArray *cells = [sections objectAtIndex:indexPath.section];
      id object = [cells objectAtIndex:indexPath.row - 1];
      if ([object isKindOfClass:[Task class]]) {
         __block double totalHours = 0;
         [((Task *)object).subTasks each:^(Subtask *st) {
            totalHours += [st.time doubleValue];
         }];
         
         if ([self isAlreadyShowingContent:indexPath]) {
            [cell.disclosureButton setStyle:kFRDLivelyButtonStyleCaretDown animated:YES];
         } else {
            [cell.disclosureButton setStyle:kFRDLivelyButtonStyleCaretLeft animated:YES];
         }
         cell.mainText.text = [NSString stringWithFormat:@"%2.fhrs", totalHours];
         cell.subText.text = ((Task *)object).name;
         cell.extraText.text = ((Task *)object).category_name;
      } else if ([object isKindOfClass:[Subtask class]]){
         cell.mainText.text = [NSString stringWithFormat:@"%@hrs", ((Subtask *)object).time];
         cell.subText.text = ((Subtask *)object).name;
         cell.extraText.text = ((Subtask *)object).desc;
      }
      
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
   } else if (indexPath.row == 0) {
      Week *week = (Week*)[weeks objectAtIndex:indexPath.section];
      cell.mainText.text = [NSString stringWithFormat:@"%@ tan", week.totalHours];
      cell.subText.text = [NSString stringWithFormat:@"%@ total", week.totalHours];
      double percentage = [self percentageRelatedToWorkedHours:week.totalHours.doubleValue];
      cell.progressBar.progress = percentage;
      [cell setProgressBarColor:[self colorForHoursMade:week.totalHours.doubleValue]];
   }
   
   return cell;
}

- (NSString *)getIdentifierForIndexPath:(NSIndexPath *)indexPath {
   NSInteger totalRows = [[sections objectAtIndex:indexPath.section] count] + 2;
   if (indexPath.row == 0) { return FIRST_CELL_IDENTIFIER;
   } else if (indexPath.row == totalRows - 1) {
      return FOOTER_CELL_IDENTIFIER;
   } else {
      NSArray *cells = [sections objectAtIndex:indexPath.section];
      if (cells.count > 0) {
         id object = [cells objectAtIndex:indexPath.row - 1];
         if ([object isKindOfClass:[Task class]]) {
            return TASK_CELL_IDENTIFIER;
         } else if ([object isKindOfClass:[Subtask class]]){
            return SUB_TASK_CELL_IDENTIFIER;
         }
      }
   }
   return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   NSArray *cells = [sections objectAtIndex:section];
   return  [cells count] + 2;
}

#pragma mark Header Initialization
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   OCCustomTableViewCell *cell;
   cell = (OCCustomTableViewCell *)[self buildCellWithIdentifier:HEADER_CELL_IDENTIFIER andAction:nil];
   if (section != 0) {
      cell.backgroundColor = [UIColor darkGrayColor];
      cell.backgroundView.backgroundColor = [UIColor darkGrayColor];
   }
   NSNumber *weekNumber = ((Week*)[weeks objectAtIndex:section]).weekNumber;
   cell.mainText.text = [NSString stringWithFormat:@"Week %@", weekNumber];
   return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return [sections count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return HEADER_SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   //   return (indexPath.row == 0) ? PROGRESS_CELL_SIZE : RECORD_CELL_SIZE;
   NSInteger totalRows = [[sections objectAtIndex:indexPath.section] count] + 2;
   if (indexPath.row == 0) {
      return PROGRESS_CELL_SIZE;
   } else if (indexPath.row == totalRows - 1) {
      return FOOTER_SIZE;
   }
   return [tableView fd_heightForCellWithIdentifier:TASK_CELL_IDENTIFIER cacheByIndexPath:indexPath configuration:^(id cell) {
      // configurations
      //      NSArray *logs = [[weeks objectAtIndex:indexPath.section] objectForKey:@"logs"];
      //      NSDictionary *tempDic = [logs objectAtIndex:indexPath.row - 1];
      //      ((OCCustomTableViewCell *)cell).extraText.text = [tempDic valueForKey:@"description"];
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
   NSInteger totalRows = [[sections objectAtIndex:indexPath.section] count] + 2;
   [_tableView deselectRowAtIndexPath:indexPath animated:YES];
   if (indexPath.row != 0 && indexPath.row < totalRows - 1) {
      if (![self isAlreadyShowingContent:indexPath]) {
         [self inserRowsWithIndexPath:indexPath];
         OCCustomTableViewCell *cell = (OCCustomTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
         [cell.disclosureButton setStyle:kFRDLivelyButtonStyleCaretDown animated:YES];
      } else {
         [self removeRowsWithIndexPath:indexPath];
         OCCustomTableViewCell *cell = (OCCustomTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
         [cell.disclosureButton setStyle:kFRDLivelyButtonStyleCaretLeft animated:YES];
      }
   }
}

- (void)inserRowsWithIndexPath:(NSIndexPath *)indexPath {
   NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
   id object = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row - 1];
   if ([object isKindOfClass:[Task class]]) {
      [((Task*)object).subTasks eachWithIndex:^(Subtask *st, NSUInteger index) {
         NSUInteger arrayIndex =  (indexPath.row-1) + 1;
         [[sections objectAtIndex:indexPath.section] insertObject:st atIndex:arrayIndex];
         
         NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + index + 1)
                                                        inSection:indexPath.section];
         [indexPaths addObject:newIndexPath];
      }];
   }
   [_tableView beginUpdates];
   [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
   //   [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
   [_tableView endUpdates];
}

- (void)removeRowsWithIndexPath:(NSIndexPath *)indexPath {
   NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
   id object = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row - 1];
   if ([object isKindOfClass:[Task class]]) {
      [((Task*)object).subTasks eachWithIndex:^(Subtask *st, NSUInteger index) {
         NSUInteger arrayIndex =  (indexPath.row-1) + 1;
         [[sections objectAtIndex:indexPath.section] removeObjectAtIndex:arrayIndex];
         
         NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + index + 1)
                                                        inSection:indexPath.section];
         [indexPaths addObject:newIndexPath];
      }];
   }
   [_tableView beginUpdates];
   [_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
   [_tableView endUpdates];
}

- (BOOL)isAlreadyShowingContent:(NSIndexPath *)indexPath {
   if ([[sections objectAtIndex:indexPath.section] count] > 1) {
      if ([[sections objectAtIndex:indexPath.section] count] - 1 >= (indexPath.row-1) + 1) {
         id object = [[sections objectAtIndex:indexPath.section] objectAtIndex:(indexPath.row-1) + 1];
         return [object isKindOfClass:[Subtask class]];
      }
   }
   return NO;
}

#pragma mark - IBActions
- (IBAction)addRowToSection:(id)sender {
   [self performSegueWithIdentifier:@"goToNewActivity" sender:self];
}

- (IBAction)addComment:(id)sender {
   REComposeViewController *composeViewController = [[REComposeViewController alloc] init];
   composeViewController.title = @"New Comment";
   composeViewController.hasAttachment = YES;
   composeViewController.placeholderText = @"What do you want to share?";
   [composeViewController presentFromRootViewController];
   
   composeViewController.completionHandler = ^(REComposeViewController *composeViewController, REComposeResult result) {
      [composeViewController dismissViewControllerAnimated:YES completion:nil];
      
      if (result == REComposeResultCancelled) {
         NSLog(@"Cancelled");
      }
      
      if (result == REComposeResultPosted) {
         NSLog(@"Text: %@", composeViewController.text);
      }
   };
}

- (NSIndexPath *) getButtonIndexPath:(UIButton *) button
{
   CGRect buttonFrame = [button convertRect:button.bounds toView:_tableView];
   return [_tableView indexPathForRowAtPoint:buttonFrame.origin];
}

#pragma mark - IOS Slide Menu Delegate
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu {
   return (_outsideUser == nil);
}

@end