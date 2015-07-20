//
//  OCNewActivityViewController.h
//  One Community
//
//  Created by Gustavo Romito on 7/12/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCBaseWithouMenuViewController.h"
@import TextFieldEffects;

@interface OCNewActivityViewController : OCBaseWithouMenuViewController
@property (strong, nonatomic) IBOutlet HoshiTextField *titleTextField;
@property (strong, nonatomic) IBOutlet HoshiTextField *hoursTextField;
@property (strong, nonatomic) IBOutlet UITextField *descriptionTextField;

- (IBAction)categoryPicker:(id)sender;
- (IBAction)tasksPicker:(id)sender;
- (IBAction)cancelTapped:(id)sender;
- (IBAction)saveTapped:(id)sender;

@end
