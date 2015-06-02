//
//  MCustomTableViewCell.h
//  Moblyboy
//
//  Created by Gustavo Romito on 3/1/15.
//  Copyright (c) 2015 MKM Brasil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCCustomTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *leftIcon;
@property (strong, nonatomic) IBOutlet UILabel *mainText;
@property (strong, nonatomic) IBOutlet UILabel *subText;

@end
