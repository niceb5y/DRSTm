//
//  FirstViewController.m
//  DRST manager
//
//  Created by 김승호 on 2015. 11. 21..
//  Copyright © 2015년 Seungho Kim. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property NSTimer *timer;
@property DataKit *dk;
@property int deviceIndex;

@end

@implementation FirstViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_dk = [[DataKit alloc] init];
	_segmentedButton.hidden = ![self.dk dualAccountEnabled];
	_deviceIndex = 0;
	[self refresh];
	_timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(refresh:) userInfo:nil repeats:YES];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	_segmentedButton.hidden = ![self.dk dualAccountEnabled];
	if (![self.dk dualAccountEnabled]) {
		_deviceIndex = 0;
	}
	[self refresh];
}

- (void)refresh {
	int max = (int)[self.dk maxStamina:_deviceIndex];
	int cur = (int)[self.dk estimatedCurrentStamina:_deviceIndex];
	_lbStamina.text = [NSString stringWithFormat:@"%d/%d", cur, max];
	_progress.progress = (double)cur / max;
	_lbEstimate.text = [NSString stringWithFormat: @"예상 스태미너 MAX 시간: %@", [self.dk estimatedCompleteTimeString:_deviceIndex]];
	_lbTimeLeft.text = [self.dk estimatedTimeLeftString:_deviceIndex];
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
