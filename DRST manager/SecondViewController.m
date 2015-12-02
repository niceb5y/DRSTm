//
//  SecondViewController.m
//  DRST manager
//
//  Created by 김승호 on 2015. 11. 22..
//  Copyright © 2015년 Seungho Kim. All rights reserved.
//

#import "SecondViewController.h"
#import <SafariServices/SafariServices.h>

@interface SecondViewController ()

@property DataController *data;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	_data = [[DataController alloc] init];
	[_accountSwitch setOn:[self.data dualAccount]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 1) {
		if (indexPath.row == 0) {
			SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"https://twitter.com/deresute_border"]];
			[self presentViewController:vc animated:YES completion:nil];
		}
	}else if (indexPath.section == 2) {
		if (indexPath.row == 0) {
			NSURL* url = [[NSURL alloc] initWithString:@"mailto:niceb5y+drstm@gmail.com?subject=%EB%8B%B9%EC%8B%A0%EC%9D%B4%20%EC%96%B4%EC%A7%B8%EC%84%9C%20%EA%B0%9C%EB%B0%9C%EC%9E%90%EC%9D%B8%EA%B1%B0%EC%A3%A0%3F"];
			[[UIApplication sharedApplication] openURL:url];
		}
	}
}

- (IBAction)accountSwitchTouched:(id)sender {
	[self.data setDualAccount:[_accountSwitch isOn]];
}

- (IBAction)notificationSwitchTouched:(id)sender {
	[self.data setNotification:[_notificationSwitch isOn]];
	if ([_notificationSwitch isOn]) {
		UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil];
		[[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
		[[UIApplication sharedApplication] registerForRemoteNotifications];
		[self.data registerNotifications];
	} else {
		[self.data releaseNotifications];
	}
}

@end
