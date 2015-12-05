//
//  EditViewController.h
//  DRST manager
//
//  Created by 김승호 on 2015. 11. 21..
//  Copyright © 2015년 Seungho Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationKit.h"

@import DRSTDataKit;
@class DataKit;

@interface EditViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtMax;
@property (weak, nonatomic) IBOutlet UITextField *txtCurrent;
@property (weak, nonatomic) IBOutlet UIStepper *stepMax;
@property (weak, nonatomic) IBOutlet UIStepper *stepCurrent;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedButton;
- (IBAction)txtMaxTouched:(id)sender;
- (IBAction)TextCurrentTouched:(id)sender;
- (IBAction)stepMaxTouched:(id)sender;
- (IBAction)stepCurrentTouched:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)segmentedButtonTouched:(id)sender;

@end
