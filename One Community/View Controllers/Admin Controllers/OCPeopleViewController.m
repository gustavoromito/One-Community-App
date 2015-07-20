//
//  OCPeopleViewController.m
//  One Community
//
//  Created by Gustavo Romito on 6/19/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCPeopleViewController.h"
#import "OCCustomTableViewCell.h"
#import "OCDashboardViewController.h"
#import <HexColors/HexColors.h>

#import "OCHTTPClient.h"

#define USER_CELL_IDENTIFIER @"userCell"

@interface OCPeopleViewController () {
   NSArray *people;
}

@end

@implementation OCPeopleViewController

- (void)viewDidLoad {
   [super viewDidLoad];
//   people = @[@{@"userid": @1,
//                @"name": @"Gustavo Romito",
//                @"totalHours":[NSNumber numberWithDouble:[self randomDoubleForMax:80]]
//                },
//              @{@"userid": @1,
//                @"name": @"Fernando Bitencourt",
//                @"totalHours": [NSNumber numberWithDouble:[self randomDoubleForMax:80]]
//                },
//              @{@"userid": @1,
//                @"name": @"Gabriel Freitas",
//                @"totalHours": [NSNumber numberWithDouble:[self randomDoubleForMax:80]]
//                },
//              @{@"userid": @1,
//                @"name": @"Beatriz Rocha",
//                @"totalHours": [NSNumber numberWithDouble:[self randomDoubleForMax:80]]
//                },
//              @{@"userid": @1,
//                @"name": @"Rodrigo Nobre",
//                @"totalHours": [NSNumber numberWithDouble:[self randomDoubleForMax:80]]
//                },
//              @{@"userid": @1,
//                @"name": @"Antonio Zambianco",
//                @"totalHours": [NSNumber numberWithDouble:[self randomDoubleForMax:80]]
//                },
//              @{@"userid": @1,
//                @"name": @"Maurilio Souza",
//                @"totalHours": [NSNumber numberWithDouble:[self randomDoubleForMax:80]]
//                },
//              @{@"userid": @1,
//                @"name": @"Tomas Lagon",
//                @"totalHours": [NSNumber numberWithDouble:[self randomDoubleForMax:80]]
//                },
//              @{@"userid": @1,
//                @"name": @"Mateus Baba",
//                @"totalHours": [NSNumber numberWithDouble:[self randomDoubleForMax:80]]
//                },
//              @{@"userid": @1,
//                @"name": @"Roberto Mito",
//                @"totalHours": [NSNumber numberWithDouble:[self randomDoubleForMax:80]]
//                },
//              @{@"userid": @1,
//                @"name": @"Eddie Zorro",
//                @"totalHours": [NSNumber numberWithDouble:[self randomDoubleForMax:80]]
//                }];
   [self fetchAPIData];
   // Do any additional setup after loading the view.
}

- (void)fetchAPIData {
   NSString *requestPath = @"users/collaborators";
   MBProgressHUD *hud = [self showHUDwithTitle:@"Please, wait..." andDetail:@"loading collaborators."];
   OCHTTPClient *client = [OCHTTPClient privateClient];
   [client GET:requestPath
    parameters:@{}
       success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if ([[responseObject valueForKey:@"success"] intValue] == 0) {
             [self showAlertWithTitle:@"Alert:" andMessage:[responseObject valueForKey:@"message"]];
          }else{
             people = [responseObject objectForKey:@"users"];
             NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"totalHours"  ascending:NO];
             people=[people sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
             [_tableView reloadData];
          }
          [hud hide:YES];
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          [hud hide:YES];
          [self showAppropriateFailureMessageWithResponseObject:operation.responseObject];
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
   cell = (OCCustomTableViewCell *)[self buildCellWithIdentifier:USER_CELL_IDENTIFIER andAction:nil];
   NSDictionary *person = [people objectAtIndex:indexPath.row];
   double hoursMade = [[person valueForKey:@"totalHours"] doubleValue];
   double percentage = [self percentageRelatedToWorkedHours:hoursMade];
   cell.progressBar.progress = percentage;
   [cell setProgressBarColor:[self colorForHoursMade:hoursMade]];
//   cell.backgroundColor = [self backgroundColorForIndexPath:indexPath];
   
   NSRange range = [self rangeForWorkedHours:hoursMade];
   
   cell.extraText.text = [NSString stringWithFormat:@"%lu", (unsigned long)range.location];
   cell.extraText2.text = [NSString stringWithFormat:@"%lu", (unsigned long)(range.location + range.length)];
   cell.mainText.text = [NSString stringWithFormat:@"%ldº %@",(long)indexPath.row+1, [person valueForKey:@"name"]];
   cell.subText.text = [NSString stringWithFormat:@"%.2f hours made", [[person valueForKey:@"totalHours"] doubleValue]];
   
   return cell;
}

- (UIColor *)backgroundColorForIndexPath:(NSIndexPath*)indexPath {
   if (indexPath.row == 0) {
      return [UIColor colorWithHexString:@"#FFDF00"];
   } else if (indexPath.row == 1) {
      return [UIColor colorWithHexString:@"#C0C0C0"];
   } else if (indexPath.row == 2) {
      return [UIColor colorWithHexString:@"#cd7f32"];
   }
   return [UIColor groupTableViewBackgroundColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [people count];
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
   [self performSegueWithIdentifier:@"goToDashboard" sender:indexPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   if ([[segue identifier] isEqualToString:@"goToDashboard"]) {
      NSIndexPath *indexPath = (NSIndexPath*)sender;
      NSDictionary *dic = [people objectAtIndex:indexPath.row];
      OCDashboardViewController *vc = [segue destinationViewController];
      User *user = [[User alloc] initWithUserId:[dic valueForKey:@"user_id"] andUserName:[dic valueForKey:@"name"]];
      vc.outsideUser = user;
   }
}

@end
