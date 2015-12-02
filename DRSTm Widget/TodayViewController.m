//
//  TodayViewController.m
//  DRSTm Widget
//
//  Created by 김승호 on 2015. 11. 21..
//  Copyright © 2015년 Seungho Kim. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>
@property NSTimer* timer;
@property DataController *data;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	_data = [[DataController alloc] init];
	[_lbTimeLeft.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
	[_lbTimeLeft .titleLabel setTextAlignment:NSTextAlignmentCenter];
	[self refresh];
	_timer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(refresh:) userInfo:nil repeats:YES];
}

- (void)refresh {
	[_indicator stopAnimating];
	if ([self.data dualAccount]) {
		self.preferredContentSize = CGSizeMake(0, 98);
		[_lbTimeLeft setTitle:[NSString
							stringWithFormat:@"기기 1: 스태미너 %d / %d\n%@ 남음\n기기 2: 스태미너 %d / %d\n%@ 남음",
							[self.data estimatedCurrentStaminaAtIndex:0],
							[self.data maxStaminaAtIndex:0],
							[self.data estimatedTimeLeftStringAtIndex:0],
							[self.data estimatedCurrentStaminaAtIndex:1],
							[self.data maxStaminaAtIndex:1],
							[self.data estimatedTimeLeftStringAtIndex:1]] forState:UIControlStateNormal];
	} else {
		self.preferredContentSize = CGSizeMake(0, 57);
		[_lbTimeLeft setTitle:[NSString stringWithFormat:@"스태미너 %d / %d\n%@ 남음",
							[self.data estimatedCurrentStaminaAtIndex:0],
							[self.data maxStaminaAtIndex:0],
							[self.data estimatedTimeLeftStringAtIndex:0]] forState:UIControlStateNormal];
	}
}

- (void)refresh: (NSTimer *)aTimer {
	[self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	if (_timer != nil) {
		[_timer invalidate];
		_timer = nil;
	}
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
	return UIEdgeInsetsZero;
}
- (IBAction)edit:(id)sender {
	NSURL *url = [NSURL URLWithString:@"DRSTm://"];
	[self.extensionContext openURL:url completionHandler:nil];
}
@end
