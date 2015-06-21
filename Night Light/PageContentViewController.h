//
//  PageContentViewController.h
//  Night Light
//
//  Created by felix king on 20/06/2015.
//  Copyright (c) 2015 Felix King. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *timePickerView;

- (IBAction)settingsButtonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

- (IBAction)brightnessSliderChanged:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;

@property (weak, nonatomic) IBOutlet UILabel *brightnessLabel;

@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;

@property NSInteger count;
@property NSInteger time;
@property NSTimer *timer;
@property NSTimer *sleepTimer;

@property NSString *textColour;

@property NSInteger mins;
@property NSInteger secs;

@end
