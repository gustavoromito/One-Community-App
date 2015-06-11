//
//  OCActivitiesViewController.m
//  One Community
//
//  Created by Gustavo Romito on 6/1/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCActivitiesViewController.h"
#import "OCProgramCell.h"
#import "OCProgramDetailsViewController.h"

#import <HexColors/HexColor.h>

#define PROGRAM_CELL_IDENTIFIER @"programCell"
@interface OCActivitiesViewController() {
   NSArray *programs;
   NSArray *colors;
   UIColor *selectedColor;
}
@end

@implementation OCActivitiesViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   [self sideMenuSetup];
   [self.navigationController.navigationBar setHidden:NO];
   [self exchangeBackButtonForCustomMenuButton];
   
   programs = @[@"Hiking", @"Code Class", @"Painting", @"Yoga Class", @"Cooking",
                @"Acting", @"Cycling", @"Football", @"Soccer", @"Basketball"];
   colors = @[@"437D8F", @"4F8767", @"BABA8F", @"085E85", @"D7222C", @"BABA2B", @"7D5F54", @"6B696A", @"6A7FC1", @"BCA6A0"];
   // Do any additional setup after loading the view.
}

#pragma mark - Side Menu Helpers
- (void)exchangeBackButtonForCustomMenuButton {
   UIBarButtonItem *menuBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-button"]
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(toggleLeftMenu)];
   self.navigationItem.leftBarButtonItem = menuBarButton;
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
   [super viewDidAppear:animated];
}

#pragma mark - Table view data source
#pragma mark Cell Initialization
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   OCProgramCell *cell;
   cell = (OCProgramCell *)[self buildCellWithIdentifier:PROGRAM_CELL_IDENTIFIER andAction:nil];
   int quant = arc4random_uniform(20);
   [cell setupWithTitle:[programs objectAtIndex:indexPath.row]
            refreshDate:[NSDate dateWithTimeIntervalSince1970:NSTimeIntervalSince1970]
               quantity:quant
               andColor:[colors objectAtIndex:indexPath.row]];
   
   return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [programs count];
}

#pragma mark Header Initialization
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return 0.01f;
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
   OCProgramCell *cell = (OCProgramCell *)[_tableView dequeueReusableCellWithIdentifier:identifier];
   if (cell == nil) cell = [[OCProgramCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
   return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   [_tableView deselectRowAtIndexPath:indexPath animated:YES];
   selectedColor = [UIColor colorWithHexString:[colors objectAtIndex:indexPath.row]];
   [self performSegueWithIdentifier:@"goToProgramDetails" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   if ([[segue identifier] isEqualToString:@"goToProgramDetails"]) {
      OCProgramDetailsViewController *nextViewController = [segue destinationViewController];
      nextViewController.color = selectedColor;
   }
}


@end
