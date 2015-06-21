//
//  PageContentViewController.m
//  Night Light
//
//  Created by felix king on 20/06/2015.
//  Copyright (c) 2015 Felix King. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController () {
    NSArray *_pickerData;
}

@end

@implementation PageContentViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom init
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.brightnessSlider.value = [UIScreen mainScreen].brightness;
    
    self.backgroundImage.image = [UIImage imageNamed:self.imageFile];
    self.titleLabel.text = self.titleText;
    if ([self.textColour isEqualToString:@"white"]) {
        self.titleLabel.textColor = [UIColor whiteColor];
        self.timePickerView.backgroundColor = [UIColor whiteColor];
        [self.settingsButton setImage:[UIImage imageNamed:@"settingsWhite"] forState:UIControlStateNormal];
        self.brightnessLabel.textColor = [UIColor whiteColor];
    }
    else {
        self.titleLabel.textColor = [UIColor blackColor];
        self.timePickerView.backgroundColor = [UIColor clearColor];
        [self.settingsButton setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
        self.brightnessLabel.textColor = [UIColor blackColor];
    }
    _pickerData = @[@"5", @"10", @"20", @"30", @"45", @"1 Min", @"1.5 Mins", @"2 Mins", @"2.5 Mins", @"3 Mins", @"5 Mins"];
    
    self.timePickerView.dataSource = self;
    self.timePickerView.delegate = self;
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    [self.timer invalidate];
    [self.sleepTimer invalidate];
    self.timer = nil;
    self.sleepTimer = nil;
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
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    self.count = 0;
    
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
    self.sleepTimer = [NSTimer scheduledTimerWithTimeInterval:self.time + 1 target:self selector:@selector(sleepDevice) userInfo:nil repeats:NO];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"settingsSegue"]) {
        
        // get desitantion VC
        
        // pass the info to your new desination
    }
}

- (void) sleepDevice {
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    NSLog(@"Device is alseep");
    
    [self.sleepTimer invalidate];
    self.sleepTimer = nil;
}

- (void) countDown {
    self.count += 1;
    if (self.time - 1 - self.count >= 0) {
        if ((self.time - self.count) / 60 >= 1) {
            self.mins = (self.time - self.count) / 60;
            self.secs = (self.time - self.count) - self.mins * 60;
            if (self.mins > 1 && self.secs > 1) {
                self.titleLabel.text = [NSString stringWithFormat:@"%ld Mins %ld Secs", self.mins, self.secs];
            }
            else if (self.mins > 1 && self.secs == 0) {
                self.titleLabel.text = [NSString stringWithFormat:@"%ld Mins", self.mins];
            }
            else if (self.mins > 1 && self.secs == 1){
                self.titleLabel.text = [NSString stringWithFormat:@"%ld Mins %ld Sec", self.mins, self.secs];
            }
            else if (self.mins == 1 && self.secs > 1) {
                self.titleLabel.text = [NSString stringWithFormat:@"%ld Min %ld Secs", self.mins, self.secs];
            }
            else if (self.mins == 1 && self.secs == 1) {
                self.titleLabel.text = [NSString stringWithFormat:@"%ld Min %ld Sec", self.mins, self.secs];
            }
            else if (self.mins == 1 && self.secs == 0) {
                self.titleLabel.text = @"1 Min";//[NSString stringWithFormat:@"%ld Mins", self.mins];
            }
            else {
                self.titleLabel.text = @"Hello";
            }
        }
        else {
            self.secs = self.time - self.count;
            if (self.secs > 1) {
                self.titleLabel.text = [NSString stringWithFormat:@"%ld Secs", self.secs];
            }
            else {
                self.titleLabel.text = [NSString stringWithFormat:@"%ld Sec", self.secs];
            }
        }
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
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
    [self.timer invalidate];
    [self.sleepTimer invalidate];
    self.timer = nil;
    self.sleepTimer = nil;
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}
- (IBAction)brightnessSliderChanged:(UISlider *)sender {
    [UIScreen mainScreen].brightness = self.brightnessSlider.value;
}
@end
