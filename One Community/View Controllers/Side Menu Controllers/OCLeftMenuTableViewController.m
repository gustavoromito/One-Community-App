//
//  MLeftMenuTableViewController.m
//  Moblyboy
//
//  Created by Gustavo Romito on 2/23/15.
//  Copyright (c) 2015 MKM Brasil. All rights reserved.
//

#import "OCLeftMenuTableViewController.h"
#import "OCCustomTableViewCell.h"

#define MENU_CELL_HEIGHT 82.0f
#define HEADER_CELL_HEIGHT 37.0f

@interface OCLeftMenuTableViewController ()
{
   NSArray *_menuList;
   NSArray *_imageList;
}
@end

@implementation OCLeftMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   _menuList = @[@[@"News", @"Programs", @"Scan", @"Profile"], @[@"Dashboard", @"People"]];
   _imageList = @[@[[UIImage imageNamed:@"news_icon"], [UIImage imageNamed:@"programs_icon"], [UIImage imageNamed:@"scan_icon"], [UIImage imageNamed:@"profile_icon"]], @[[UIImage imageNamed:@"dashboardIcon"], [UIImage imageNamed:@"peopleIcon"]]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
#pragma mark Cell Initialization
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   OCCustomTableViewCell *cell;
   cell = (OCCustomTableViewCell *)[self buildCellWithIdentifier:@"menuItemCell" andAction:nil];
   cell.mainText.text = [[_menuList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
   cell.leftIcon.image = [[_imageList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
   return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   return MENU_CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [[_menuList objectAtIndex:section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return [_menuList count];
}

#pragma mark Header Initialization
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   OCCustomTableViewCell *cell;
   cell = (OCCustomTableViewCell *)[self buildCellWithIdentifier:@"headerCell" andAction:nil];
   cell.mainText.text = section == 0 ? @"Features" : @"Admin";
   return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return HEADER_CELL_HEIGHT;
}

#pragma mark Footer Initialization
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
   return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   return 0.01f;
}

#pragma mark Header/Footer Helpers
- (UITableViewCell *)buildCellWithIdentifier:(NSString *)identifier andAction:(SEL)action {
   OCCustomTableViewCell *cell = (OCCustomTableViewCell *)[_optionsTableView dequeueReusableCellWithIdentifier:identifier];
   if (cell == nil) cell = [[OCCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
   return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   [_optionsTableView deselectRowAtIndexPath:indexPath animated:YES];
   switch (indexPath.section) {
      case 0:
         switch (indexPath.row) {
            case 0:
               [self pushNewsViewController];
               break;
            case 1:
               [self pushProgramsViewController];
               break;
            case 2:
               [self pushScanViewController];
               break;
            case 3:
               [self pushProfileViewController];
               break;
            default:
               break;
         }
         break;
      case 1:
         switch (indexPath.row) {
            case 0:
               [self pushAdminDashboards];
               break;
            case 1:
               [self pushPeopleViewController];
               break;
            default:
               break;
         }
         break;
      default:
         break;
   }
}

@end
