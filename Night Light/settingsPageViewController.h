//
//  settingsPageViewController.h
//  Night Light
//
//  Created by felix king on 20/06/2015.
//  Copyright (c) 2015 Felix King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "staticViewController.h"

@interface settingsPageViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, staticViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseColourLabel;

- (IBAction)backButtonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

- (IBAction)staticViewButtonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *staticViewButton;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UIPickerView *colourPicker;

@property NSInteger currentColour;

@end
