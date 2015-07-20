//
//  OCNewActivityViewController.m
//  One Community
//
//  Created by Gustavo Romito on 7/12/15.
//  Copyright (c) 2015 Gustavo Romito. All rights reserved.
//

#import "OCNewActivityViewController.h"
#import <ActionSheetPicker/ActionSheetStringPicker.h>

@interface OCNewActivityViewController ()

@end

@implementation OCNewActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)categoryPicker:(id)sender {
   [self.view endEditing:YES];
   //   NSInteger selectedIndex = [servicesArray indexOfObject:_serviceField.text];
   //   if (selectedIndex == NSNotFound) selectedIndex = ZERO;
   ActionSheetStringPicker *picker = [ActionSheetStringPicker showPickerWithTitle:@"Select a Category:"
                                                                             rows:@[@"category 1", @"category 2"]
                                                                 initialSelection:0
                                                                        doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                                           ((UIButton*)sender).titleLabel.text = selectedValue;
                                                                           [self.view endEditing:YES];
                                                                        } cancelBlock:^(ActionSheetStringPicker *picker) {
                                                                           [self.view endEditing:YES];
                                                                        } origin:sender];
   picker.pickerView.backgroundColor = [UIColor whiteColor];
}

- (IBAction)tasksPicker:(id)sender {
   [self.view endEditing:YES];
   //   NSInteger selectedIndex = [servicesArray indexOfObject:_serviceField.text];
   //   if (selectedIndex == NSNotFound) selectedIndex = ZERO;
   ActionSheetStringPicker *picker = [ActionSheetStringPicker showPickerWithTitle:@"Select a Task:"
                                                                             rows:@[@"task 1", @"task 2"]
                                                                 initialSelection:0
                                                                        doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                                           ((UIButton*)sender).titleLabel.text = selectedValue;
                                                                           [self.view endEditing:YES];
                                                                        } cancelBlock:^(ActionSheetStringPicker *picker) {
                                                                           [self.view endEditing:YES];
                                                                        } origin:sender];
   picker.pickerView.backgroundColor = [UIColor whiteColor];
}

- (IBAction)cancelTapped:(id)sender {
}

- (IBAction)saveTapped:(id)sender {
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
