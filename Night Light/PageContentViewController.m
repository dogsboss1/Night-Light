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
    
    self.backgroundImage.image = [UIImage imageNamed:self.imageFile];
    self.titleLabel.text = self.titleText;
    _pickerData = @[@"5", @"10", @"20", @"30", @"45", @"1 Min", @"1.5 Mins", @"2 Mins", @"2.5 Mins", @"3 Mins", @"5 Mins"];
    
    self.timePickerView.dataSource = self;
    self.timePickerView.delegate = self;
    
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
    
    if (row == 0) {
        self.time = 5;
    } else if (row == 1) {
        self.time = 10;
    } else if (row == 1) {
        self.time = 20;
    } else if (row == 1) {
        self.time = 30;
    } else if (row == 1) {
        self.time = 45;
    } else if (row == 1) {
        self.time = 60;
    } else if (row == 1) {
        self.time = 90;
    } else if (row == 1) {
        self.time = 120;
    } else if (row == 1) {
        self.time = 150;
    } else if (row == 1) {
        self.time = 180;
    } else if (row == 1) {
        self.time = 300;
    }
    [self beginCountDownWith:self.time];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"settingsSegue"]) {
        
        // get desitantion VC
        
        // pass the info to your new desination
    }
}

- (void) beginCountDownWith:(NSInteger)time {
    self.sleepTimer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(sleepDevice) userInfo:nil repeats:NO];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}

- (void) sleepDevice {
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    NSLog(@"Device is alseep");
    [self.timer invalidate];
    [self.sleepTimer invalidate];
    self.timer = nil;
    self.sleepTimer = nil;
}

- (void) countDown {
    self.count += 1;
    if (self.time - self.count >= 0) {
        self.titleLabel.text = [NSString stringWithFormat:@"%ld", self.time - self.count];
    } else {
        [self.timer invalidate];
        self.timer = nil;
        NSLog(@"Stopped Timer");
        self.titleLabel.text = @"Good Night";
    }
}

@end
