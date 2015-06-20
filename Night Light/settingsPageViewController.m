//
//  settingsPageViewController.m
//  Night Light
//
//  Created by felix king on 20/06/2015.
//  Copyright (c) 2015 Felix King. All rights reserved.
//

#import "settingsPageViewController.h"

@interface settingsPageViewController () {
    NSArray *_colourPickerData;
}

@end

@implementation settingsPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _colourPickerData = @[@"Black", @"Blue", @"Cyan", @"Green", @"Orange", @"Pink", @"Red", @"White", @"Yellow", @"Rainbow"];
    self.colourPicker.delegate = self;
    self.colourPicker.dataSource = self;
    
    self.backgroundImage.image = [UIImage imageNamed:@"white"];
}

- (IBAction)backButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _colourPickerData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _colourPickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.backgroundImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", _colourPickerData[row]]];
}
@end
