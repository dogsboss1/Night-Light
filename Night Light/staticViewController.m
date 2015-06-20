//
//  staticViewController.m
//  Night Light
//
//  Created by felix king on 20/06/2015.
//  Copyright (c) 2015 Felix King. All rights reserved.
//

#import "staticViewController.h"

@interface staticViewController () {
    NSArray *_pickerData;
}

@end

@implementation staticViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom init
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"colour: %ld", [self.delegate getCurentColour]);
    
    _pickerData = @[@"5", @"10", @"20", @"30", @"45", @"1 Min", @"1.5 Mins", @"2 Mins", @"2.5 Mins", @"3 Mins", @"5 Mins"];
    self.pageTitles = @[@"white", @"black", @"blue", @"cyan", @"green", @"orange", @"pink", @"red", @"yellow", @"rainbow"];
    
    self.backgroundImage.image = [UIImage imageNamed:self.pageTitles[[self.delegate getCurentColour]]];
    self.titleLabel.text = self.pageTitles[[self.delegate getCurentColour]];
    
    if ([self.pageTitles[[self.delegate getCurentColour]] isEqualToString:@"black"]) {
        self.titleLabel.textColor = [UIColor whiteColor];
        self.timePicker.backgroundColor = [UIColor whiteColor];
        [self.backButton setImage:[UIImage imageNamed:@"backArrowsWhite"] forState:UIControlStateNormal];
        [self.settingsButton setImage:[UIImage imageNamed:@"settingsWhite"] forState:UIControlStateNormal];
    }
    else {
        self.titleLabel.textColor = [UIColor blackColor];
        self.timePicker.backgroundColor = [UIColor clearColor];
        [self.backButton setImage:[UIImage imageNamed:@"backArrows"] forState:UIControlStateNormal];
        [self.settingsButton setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    }
    
    self.timePicker.dataSource = self;
    self.timePicker.delegate = self;
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _pickerData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _pickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.titleLabel.text = [NSString stringWithFormat:@"%@", _pickerData[row]];
    
    [self.timer invalidate];
    [self.sleepTimer invalidate];
    self.timer = nil;
    self.sleepTimer = nil;
    
    //self.count = 0;
    
    if (row == 0) {
        self.time = 5;
    } else if (row == 1) {
        self.time = 10;
    } else if (row == 2) {
        self.time = 20;
    } else if (row == 3) {
        self.time = 30;
    } else if (row == 4) {
        self.time = 45;
    } else if (row == 5) {
        self.time = 60;
    } else if (row == 6) {
        self.time = 90;
    } else if (row == 7) {
        self.time = 120;
    } else if (row == 8) {
        self.time = 150;
    } else if (row == 9) {
        self.time = 180;
    } else if (row == 10) {
        self.time = 300;
    }
    self.sleepTimer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(sleepDevice) userInfo:nil repeats:NO];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}

- (void) sleepDevice {
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    NSLog(@"Device is alseep");
    
    [self.sleepTimer invalidate];
    self.sleepTimer = nil;
}

- (void) countDown {
    self.count += 1;
    if (self.time - self.count >= 0) {
        self.titleLabel.text = [NSString stringWithFormat:@"%ld", self.time - self.count];
        NSLog(@"time: %ld count: %ld time - count %ld", self.time, self.count, self.time - self.count);
    } else {
        [self.timer invalidate];
        self.timer = nil;
        self.count = 0;
        NSLog(@"Stopped Timer");
        self.titleLabel.text = @"Good Night";
    }
}

- (IBAction)settingsButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"oldStyleSegue" sender:self];
}
@end