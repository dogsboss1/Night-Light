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

@interface staticViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)backButtonPressed:(UIButton *)sender;
- (IBAction)settingsButtonPressed:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UIPickerView *timePicker;

@property (strong, nonatomic) NSArray *pageTitles;

@property NSInteger count;
@property NSInteger time;
@property NSTimer *timer;
@property NSTimer *sleepTimer;

@property NSString *textColour;

@property (nonatomic, weak) id<staticViewDelegate> delegate;

@end
