//
//  ViewController.h
//  Night Light
//
//  Created by felix king on 20/06/2015.
//  Copyright (c) 2015 Felix King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface ViewController : UIViewController <UIPageViewControllerDataSource>

- (IBAction)startWalkthroughButtonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *startAgainButton;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;

@property NSInteger index;

@end

