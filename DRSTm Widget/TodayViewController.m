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
@property NSTimer *timer;
@property DataKit *dk;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	_dk = [[DataKit alloc] init];
	[_lbTimeLeft.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
	[_lbTimeLeft .titleLabel setTextAlignment:NSTextAlignmentCenter];
	[self refresh];
	_timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(refresh:) userInfo:nil repeats:YES];
}

- (void)refresh {
	[_indicator stopAnimating];
	if ([self.dk dualAccountEnabled]) {
		self.preferredContentSize = CGSizeMake(0, 98);
		[_lbTimeLeft setTitle:[NSString
							stringWithFormat:@"기기 1: 스태미너 %d / %d\n%@ 남음\n기기 2: 스태미너 %d / %d\n%@ 남음",
							(int)[self.dk estimatedCurrentStamina:0],
							(int)[self.dk maxStamina:0],
							[self.dk estimatedTimeLeftString:0],
							(int)[self.dk estimatedCurrentStamina:1],
							(int)[self.dk maxStamina:1],
							[self.dk estimatedTimeLeftString:1]] forState:UIControlStateNormal];
	} else {
		self.preferredContentSize = CGSizeMake(0, 57);
		[_lbTimeLeft setTitle:[NSString stringWithFormat:@"스태미너 %d / %d\n%@ 남음",
							(int)[self.dk estimatedCurrentStamina:0],
							(int)[self.dk maxStamina:0],
							[self.dk estimatedTimeLeftString:0]] forState:UIControlStateNormal];
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
