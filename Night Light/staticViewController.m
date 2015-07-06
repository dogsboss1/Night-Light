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

-(void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer;

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
    
    //NSLog(@"colour: %ld", [self.delegate getCurentColour]);
    
    self.timerHasBegun = false;
    
    self.brightnessSlider.value = [UIScreen mainScreen].brightness;
    
    _pickerData = @[@"5", @"10", @"20", @"30", @"45", @"1 Min", @"1.5 Mins", @"2 Mins", @"2.5 Mins", @"3 Mins", @"5 Mins"];
    self.pageTitles = @[@"white", @"black", @"blue", @"cyan", @"green", @"orange", @"pink", @"red", @"yellow", @"rainbow"];
    
    self.backgroundImage.image = [UIImage imageNamed:self.pageTitles[[self.delegate getCurentColour]]];
    self.titleLabel.text = self.pageTitles[[self.delegate getCurentColour]];
    
    NSArray *imageNames = @[@"tmp-8.gif", @"tmp-9.gif", @"tmp-10.gif", @"tmp-11.gif",
                            @"tmp-12.gif", @"tmp-13.gif", @"tmp-14.gif", @"tmp-15.gif",
                            @"tmp-16.gif", @"tmp-0.gif", @"tmp-1.gif", @"tmp-2.gif",
                            @"tmp-3.gif", @"tmp-4.gif", @"tmp-5.gif", @"tmp-6.gif",
                            @"tmp-7.gif"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    // Normal Animation
    self.explosionImageView.animationImages = images;
    self.explosionImageView.animationDuration = 1;
    
    [self.tapButton setTitle:@"" forState:UIControlStateNormal];
    
    
    if ([self.pageTitles[[self.delegate getCurentColour]] isEqualToString:@"black"]) {
        self.titleLabel.textColor = [UIColor whiteColor];
        self.timePicker.backgroundColor = [UIColor whiteColor];
        [self.backButton setImage:[UIImage imageNamed:@"backArrowsWhite"] forState:UIControlStateNormal];
        [self.settingsButton setImage:[UIImage imageNamed:@"settingsWhite"] forState:UIControlStateNormal];
        self.brightnessLabel.textColor = [UIColor whiteColor];
    }
    else {
        self.titleLabel.textColor = [UIColor blackColor];
        self.timePicker.backgroundColor = [UIColor clearColor];
        [self.backButton setImage:[UIImage imageNamed:@"backArrows"] forState:UIControlStateNormal];
        [self.settingsButton setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
        self.brightnessLabel.textColor = [UIColor blackColor];
    }
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
    
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
/*
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    if ([self.pageTitles[[self.delegate getCurentColour]] isEqualToString:@"black"]) {
        label.textColor = [UIColor blackColor];
        label.text = @"hello";//_pickerData[row];
        label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
        label.backgroundColor = [UIColor clearColor];
    } else {
        label.textColor = [UIColor blackColor];
        label.text = @"Hi";//_pickerData[row];
        label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
        label.backgroundColor = [UIColor clearColor];
    }
    return label;
}*/

- (void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer {
    CGPoint point = [tapGestureRecognizer locationInView:self.view];
    
    if (self.timerHasBegun) {
        self.explosionImageView.frame = CGRectMake(point.x - (142 / 2), point.y - 100, 142, 200);
        
        [self.explosionImageView startAnimating];
        
        [self performSelector:@selector(stopAnimatingExplosion) withObject:self afterDelay:0.81];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.titleLabel.text = [NSString stringWithFormat:@"%@", _pickerData[row]];
    
    self.timerHasBegun = true;
    
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
        NSLog(@"time: %ld count: %ld time - count %ld", self.time, self.count, self.time - self.count);
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    } else {
        [self.timer invalidate];
        self.timer = nil;
        self.count = 0;
        NSLog(@"Stopped Timer");
        self.titleLabel.text = @"Good Night";
    }
    //NSLog(@"Mins:  %ld, secs: %ld", self.mins, self.secs);
}

- (void) stopAnimatingExplosion {
    [self.explosionImageView stopAnimating];
    self.explosionImageView.image = [UIImage imageNamed:@""];
}

- (IBAction)settingsButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"staticSettingsSegue" sender:self];
    [self.timer invalidate];
    [self.sleepTimer invalidate];
    self.timer = nil;
    self.sleepTimer = nil;
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (IBAction)backButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"oldStyleSegue" sender:self];
    [self.timer invalidate];
    [self.sleepTimer invalidate];
    self.timer = nil;
    self.sleepTimer = nil;
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (IBAction)brightnessSliderChanged:(UISlider *)sender {
    [UIScreen mainScreen].brightness = self.brightnessSlider.value;
}
- (IBAction)tapButtonPressed:(UIButton *)sender {
    [self.explosionImageView startAnimating];
    
    [self performSelector:@selector(stopAnimatingExplosion) withObject:self afterDelay:0.81];
}
@end
