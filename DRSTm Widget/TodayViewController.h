//
//  TodayViewController.h
//  DRSTm Widget
//
//  Created by 김승호 on 2015. 11. 21..
//  Copyright © 2015년 Seungho Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@import DRSTKit;
@class DataKit;

@interface TodayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *lbTimeLeft;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
- (IBAction)edit:(id)sender;

@end
