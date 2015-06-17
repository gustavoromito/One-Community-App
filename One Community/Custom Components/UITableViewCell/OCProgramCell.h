//
//
//  Created by Gustavo Romito on 06/03/15.
//  Copyright (c) 2014 One Community Global. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCProgramCell : UITableViewCell {
    NSNumberFormatter *numberFormatter;
}

@property (strong, nonatomic) IBOutlet UIView *dataContainer;
@property (strong, nonatomic) IBOutlet UILabel *refreshDate;
@property (strong, nonatomic) IBOutlet UILabel *quantityLabel;
@property (strong, nonatomic) IBOutlet UILabel *programTitle;
@property (strong, nonatomic) IBOutlet UIView *leftDetail;

#pragma mark - Cell Setup
- (void)setupWithTitle:(NSString *)title refreshDate:(NSDate *)refreshDate quantity:(NSInteger)quantity andColor:(NSString *)hexColor;

@end
