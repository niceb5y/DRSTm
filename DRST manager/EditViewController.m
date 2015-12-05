//
//  EditViewController.m
//  DRST manager
//
//  Created by 김승호 on 2015. 11. 21..
//  Copyright © 2015년 Seungho Kim. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@property DataKit *dk;
@property int deviceIndex;
@property int max;
@property int cur;

@end

@implementation EditViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_dk = [[DataKit alloc] init];
	_deviceIndex = 0;
	_segmentedButton.hidden = ![self.dk dualAccountEnabled];
	[self load];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)txtMaxTouched:(id)sender {
	[self setMaximumValue:(int)[_txtMax.text integerValue]];
}

- (IBAction)TextCurrentTouched:(id)sender {
	[self setCurrentValue:(int)[_txtCurrent.text integerValue]];
}

- (IBAction)stepMaxTouched:(id)sender {
	[self setMaximumValue:_stepMax.value];
}

- (IBAction)stepCurrentTouched:(id)sender {
	[self setCurrentValue:_stepCurrent.value];
}

- (void)save {
	[self.view endEditing:YES];
	[self.dk setMaxStamina:_max atIndex:_deviceIndex];
	[self.dk setCurrentStamina:_cur atIndex:_deviceIndex];
	[self.dk setDate:[NSDate date]];
	if ([self.dk notificationEnabled]) {
		[NotificationKit registerNotification];
	} else {
		[NotificationKit clearNotification];
	}
}

- (IBAction)save:(id)sender {
	[self save];
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)segmentedButtonTouched:(id)sender {
	[self save];
	_deviceIndex = (int)_segmentedButton.selectedSegmentIndex;
	[self load];
}

- (void)load {
	[self setMaximumValue:(int)[self.dk maxStamina:_deviceIndex]];
	[self setCurrentValue:(int)[self.dk estimatedCurrentStamina:_deviceIndex]];
}

- (void)setMaximumValue:(int)value {
	if (value > _stepMax.maximumValue) {
		value = _stepMax.maximumValue;
	} else if (value < _stepMax.minimumValue) {
		value = _stepMax.minimumValue;
	}
	_max = value;
	_txtMax.text = [NSString stringWithFormat:@"%d", value];
	_stepMax.value = value;
	_stepCurrent.maximumValue = value;
}

- (void)setCurrentValue:(int)value{
	if (value > _stepCurrent.maximumValue) {
		value = _stepCurrent.maximumValue;
	} else if (value < _stepCurrent.minimumValue) {
		value = _stepCurrent.minimumValue;
	}
	_cur = value;
	_txtCurrent.text = [NSString stringWithFormat:@"%d", value];
	_stepCurrent.value = value;
	_stepMax.minimumValue = MAX(value, 40);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.view endEditing:YES];
}

@end
