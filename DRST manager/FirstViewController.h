//
//  FirstViewController.h
//  DRST manager
//
//  Created by 김승호 on 2015. 11. 21..
//  Copyright © 2015년 Seungho Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataController.h"

@interface FirstViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbTimeLeft;
@property (weak, nonatomic) IBOutlet UILabel *lbEstimate;
@property (weak, nonatomic) IBOutlet UILabel *lbStamina;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedButton;
- (IBAction)segmentedButtonTouched:(id)sender;

@end

