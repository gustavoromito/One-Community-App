//
//  OCCommentsViewController.m
//  HG Network
//
//  Created by Gustavo Romito on 7/21/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCCommentsViewController.h"
#import "OCCustomTableViewCell.h"

#import <UITableView_FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

#define COMMENT_CELL_IDENTIFIER @"commentCell"

@interface OCCommentsViewController ()

@end

@implementation OCCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
   cell = (OCCustomTableViewCell *)[self buildCellWithIdentifier:COMMENT_CELL_IDENTIFIER andAction:nil];
   [self configCell:cell withIndexPath:indexPath];
   return cell;
}

- (void)configCell:(OCCustomTableViewCell*)cell withIndexPath:(NSIndexPath*)indexPath{
   NSDictionary *dic = [_outsideComments objectAtIndex:indexPath.section];
   cell.mainText.text = [NSString stringWithFormat:@"%@ %@ said:", [dic valueForKey:@"user_first_name"],
                         [dic valueForKey:@"user_last_name"]];
   cell.subText.text = [dic valueForKey:@"comment_description"];
   _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return 1;
}

#pragma mark Header Initialization
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   NSInteger numberOfComments = [_outsideComments count];
   if (numberOfComments == 0) {
      UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
      
      messageLabel.text = @"There is no comments for this sub task.";
      messageLabel.textColor = [UIColor lightGrayColor];
      messageLabel.numberOfLines = 0;
      messageLabel.textAlignment = NSTextAlignmentCenter;
      messageLabel.font = [UIFont systemFontOfSize:20.0f];
      [messageLabel sizeToFit];
      
      self.tableView.backgroundView = messageLabel;
      self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   }
   return numberOfComments;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   return [tableView fd_heightForCellWithIdentifier:COMMENT_CELL_IDENTIFIER cacheByIndexPath:indexPath configuration:^(id cell) {
      [self configCell:cell withIndexPath:indexPath];
   }];
}

#pragma mark Footer Initialization
-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section{
   return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   return 0.01f;
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
