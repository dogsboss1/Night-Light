//
//  staticViewController.h
//  Night Light
//
//  Created by felix king on 20/06/2015.
//  Copyright (c) 2015 Felix King. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol staticViewDelegate <NSObject>

- (NSInteger) getCurentColour;

@end

//@protocol stopStaticTimerDelegate <NSObject>

//- (BOOL) shouldStopTimer;

//@end

@interface staticViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)backButtonPressed:(UIButton *)sender;
- (IBAction)settingsButtonPressed:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UIPickerView *timePicker;

- (IBAction)brightnessSliderChanged:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;

@property (weak, nonatomic) IBOutlet UILabel *brightnessLabel;

- (IBAction)tapButtonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *explosionImageView;

@property (weak, nonatomic) IBOutlet UIButton *tapButton;

@property (strong, nonatomic) NSArray *pageTitles;

@property BOOL timerHasBegun;

@property NSInteger count;
@property NSInteger time;
@property NSTimer *timer;
@property NSTimer *sleepTimer;

@property NSString *textColour;

@property NSInteger mins;
@property NSInteger secs;

@property (nonatomic, weak) id<staticViewDelegate> delegate;

//@property (nonatomic, weak) id<stopStaticTimerDelegate> timerDelegate;

@end
