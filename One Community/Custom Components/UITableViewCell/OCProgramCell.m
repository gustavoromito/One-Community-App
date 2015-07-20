//
//
//  Created by Gustavo Romito on 06/03/15.
//  Copyright (c) 2014 One Community Global. All rights reserved.
//

#import "OCProgramCell.h"
#import <HexColors/HexColors.h>

@implementation OCProgramCell

#pragma mark - Default Initialization
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Number Formatter Helper
- (void)awakeFromNib {
    numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    numberFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"pt_BR"];
}

#pragma mark - Cell Setup & Helpers
- (void)setupWithTitle:(NSString *)title refreshDate:(NSDate *)refreshDate quantity:(NSInteger)quantity andColor:(NSString *)hexColor {
    _programTitle.text = title;
    [self setRefreshDateWithUnformattedDate:refreshDate];
    _quantityLabel.text = [NSString stringWithFormat:@"%d%%",(int)quantity];
   
    [self paintCellWithHex:hexColor];
}

- (void)setRefreshDateWithUnformattedDate:(NSDate *)date {
//    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
//    _refreshDate.text = NSStringWithFormat(_refreshDate.text,
//                                           components.day,
//                                           components.month,
//                                           components.year);
}

- (void)paintCellWithHex:(NSString *)hexString {
    UIColor *opaqueColor = [UIColor colorWithHexString:hexString];
    UIColor *translucentColor = [UIColor colorWithHexString:hexString alpha:0.7f];
    
    _dataContainer.backgroundColor = translucentColor;
    _refreshDate.textColor = [UIColor whiteColor];
    _refreshDate.backgroundColor = translucentColor;
    _programTitle.textColor = [UIColor whiteColor];
    _leftDetail.backgroundColor = opaqueColor;
}

@end
