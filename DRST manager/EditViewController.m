//
//  EditViewController.m
//  DRST manager
//
//  Created by 김승호 on 2015. 11. 21..
//  Copyright © 2015년 Seungho Kim. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()
@property DataController *data;
@property int deviceIndex;
@property int max;
@property int cur;

@end

@implementation EditViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_data = [[DataController alloc] init];
	_deviceIndex = 0;
	_segmentedButton.hidden = ![self.data dualAccount];
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
	[self.data setMaxStaminaAtIndex:_deviceIndex withValue:_max];
	[self.data setCurrentStaminaAtIndex:_deviceIndex withValue:_cur];
	[self.data setDate:[NSDate date]];
	if ([self.data notification]) {
		[self.data registerNotifications];
	} else {
		[self.data releaseNotifications];
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
	[self setMaximumValue:[self.data maxStaminaAtIndex:_deviceIndex]];
	[self setCurrentValue:[self.data estimatedCurrentStaminaAtIndex:_deviceIndex]];
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
