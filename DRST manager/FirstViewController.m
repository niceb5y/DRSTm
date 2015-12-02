//
//  FirstViewController.m
//  DRST manager
//
//  Created by 김승호 on 2015. 11. 21..
//  Copyright © 2015년 Seungho Kim. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property NSTimer* timer;
@property DataController *data;
@property int deviceIndex;

@end

@implementation FirstViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_data = [[DataController alloc] init];
	_segmentedButton.hidden = ![self.data dualAccount];
	_deviceIndex = 0;
	[self refresh];
	_timer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(refresh:) userInfo:nil repeats:YES];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	_segmentedButton.hidden = ![self.data dualAccount];
	if (![self.data dualAccount]) {
		_deviceIndex = 0;
	}
	[self refresh];
}

- (void)refresh {
	int max = [self.data maxStaminaAtIndex:_deviceIndex];
	int cur = [self.data estimatedCurrentStaminaAtIndex:_deviceIndex];
	_lbStamina.text = [NSString stringWithFormat:@"%d/%d", cur, max];
	_progress.progress = (double)cur / max;
	_lbEstimate.text = [NSString stringWithFormat: @"예상 스태미너 MAX 시간: %@", [self.data estimatedCompleteTimeStringAtIndex:_deviceIndex]];
	_lbTimeLeft.text = [self.data estimatedTimeLeftStringAtIndex:_deviceIndex];
}

- (void)refresh: (NSTimer *)aTimer {
	[self refresh];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	if (_timer != nil) {
		[_timer invalidate];
		_timer = nil;
	}
}

- (IBAction)segmentedButtonTouched:(id)sender {
	_deviceIndex = (int)_segmentedButton.selectedSegmentIndex;
	[self refresh];
}

@end
