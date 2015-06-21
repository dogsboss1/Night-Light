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
    
    self.brightnessSlider.value = [UIScreen mainScreen].brightness;
    
    _colourPickerData = @[@"white", @"black", @"blue", @"cyan", @"green", @"orange", @"pink", @"red", @"yellow", @"rainbow"];
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
    return [_colourPickerData[row] capitalizedString];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.backgroundImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", _colourPickerData[row]]];
    self.currentColour = row;
    if (row == 1) {
        self.colourPicker.backgroundColor = [UIColor whiteColor];
        self.TitleLabel.textColor = [UIColor whiteColor];
        self.chooseColourLabel.textColor = [UIColor whiteColor];
        [self.backButton setImage:[UIImage imageNamed:@"backArrowWhite"] forState:UIControlStateNormal];
        [self.staticViewButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        self.brightnessLabel.textColor = [UIColor whiteColor];
    }
    else if (row == 2) {
        [self.staticViewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.colourPicker.backgroundColor = [UIColor clearColor];
        self.TitleLabel.textColor = [UIColor blackColor];
        self.chooseColourLabel.textColor = [UIColor blackColor];
        [self.backButton setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
        self.brightnessLabel.textColor = [UIColor blackColor];
    }
    else {
        self.colourPicker.backgroundColor = [UIColor clearColor];
        self.TitleLabel.textColor = [UIColor blackColor];
        self.chooseColourLabel.textColor = [UIColor blackColor];
        [self.backButton setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
        [self.staticViewButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        self.brightnessLabel.textColor = [UIColor blackColor];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"staticSegue"]) {
        
        // get desitantion VC
        staticViewController *vc = [segue destinationViewController];
        
        // pass the info to your new desination
        vc.delegate = self;
    }
}

- (NSInteger)getCurentColour {
    return self.currentColour;
}

- (IBAction)staticViewButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"staticSegue" sender:self];
}

- (IBAction)brightnessSliderChanged:(UISlider *)sender {
    [UIScreen mainScreen].brightness = self.brightnessSlider.value;
}

@end
