//
//  SecondViewController.h
//  DRST manager
//
//  Created by 김승호 on 2015. 11. 22..
//  Copyright © 2015년 Seungho Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataController.h"

@interface SecondViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISwitch *accountSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *notificationSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *icloudSwitch;
- (IBAction)accountSwitchTouched:(id)sender;
- (IBAction)notificationSwitchTouched:(id)sender;
- (IBAction)icloudSwitchTouched:(id)sender;

@end
