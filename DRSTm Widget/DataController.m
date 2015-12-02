//
//  DataController.m
//  DRST manager
//
//  Created by 김승호 on 2015. 11. 22..
//  Copyright © 2015년 Seungho Kim. All rights reserved.
//

#import "DataController.h"

@implementation DataController

- (instancetype)init {
	if (self) {
		self = [super init];
		_defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.niceb5y.drstm"];
	}
	return self;
}

- (BOOL)dualAccount {
	BOOL _notification = [self loadBoolData:@"SetDualAccount"];
	if (!_notification) {
		_notification = NO;
	}
	return _notification;
}

- (void)setDualAccount:(BOOL)dualAccount {
	[self saveBoolData:dualAccount forKey:@"SetDualAccount"];
}

- (BOOL)notification {
	BOOL _notification = [self loadBoolData:@"SetNotification"];
	if (!_notification) {
		_notification = NO;
	}
	return _notification;
}

- (void)setNotification:(BOOL)notification {
	[self saveBoolData:notification forKey:@"SetNotification"];
}

- (NSDate *)date {
	NSDate *_date = [self loadData:@"SetDate"];
	if (!_date) {
		_date = [NSDate date];
	}
	return _date;
}

- (void)setDate:(NSDate *)date {
	[self saveData:date forKey:@"SetDate"];
}


- (void)setMaxStaminaAtIndex:(int)index withValue:(int) value {
	index = MAX(MIN(index, 1), 0);
	if ([[_stamina_max objectAtIndex:index] integerValue] != value) {
		[_stamina_max replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:value]];
		[self saveData:_stamina_max forKey:@"StaminaMax"];
	}
}

- (int)maxStaminaAtIndex:(int)index {
	index = MAX(MIN(index, 1), 0);
	_stamina_max = [[self loadData:@"StaminaMax"] mutableCopy];
	if (!_stamina_max) {
		_stamina_max = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:40], [NSNumber numberWithInt:40], nil];
	}
	return (int)[[_stamina_max objectAtIndex:index] integerValue];
}

- (void)setCurrentStaminaAtIndex:(int)index withValue:(int) value {
	index = MAX(MIN(index, 1), 0);
	if ([[_stamina_current objectAtIndex:index] integerValue] != value) {
		[_stamina_current replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:value]];
		[self saveData:_stamina_current forKey:@"StaminaCurrent"];
	}
}

- (int)currentStaminaAtIndex:(int)index {
	index = MAX(MIN(index, 1), 0);
	_stamina_current = [[self loadData:@"StaminaCurrent"] mutableCopy];
	if (!_stamina_current) {
		_stamina_current = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
	}
	return (int)[[_stamina_current objectAtIndex:index] integerValue];
}

- (int)estimatedCurrentStaminaAtIndex:(int)index {
	index = MAX(MIN(index, 1), 0);
	NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.date];
	return MIN([self currentStaminaAtIndex:index] + (interval/300), [self maxStaminaAtIndex:index]);
}

- (int)estimatedSecondLeftAtIndex:(int)index {
	index = MAX(MIN(index, 1), 0);
	NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.date];
	int steminalLeft = [self maxStaminaAtIndex:index] - [self estimatedCurrentStaminaAtIndex:index];
	return MAX(steminalLeft * 300 - ((int)interval % 300), 0);
}

- (int)estimatedMinuteLeftAtIndex:(int)index {
	return  [self estimatedSecondLeftAtIndex:index] / 60;
}

- (NSString *)estimatedTimeLeftStringAtIndex:(int)index {
	int minute = [self estimatedMinuteLeftAtIndex:index];
	if (minute > 59 && minute != 72) {
		return [NSString stringWithFormat:@"%d시간 %d분", minute / 60, minute % 60];
	} else  {
		return [NSString stringWithFormat:@"%d분",minute];
	}
}

- (NSString *)estimatedCompleteTimeStringAtIndex:(int)index {
	NSDate *completeTime = [NSDate dateWithTimeIntervalSinceNow:[self estimatedSecondLeftAtIndex:index]];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"a h시 mm분"];
	return [dateFormatter stringFromDate:completeTime];
}

- (id)loadData:(NSString *)key {
	if (_defaults && key) {
		return [_defaults objectForKey:key];
	}
	else return nil;
}

- (BOOL)loadBoolData:(NSString *)key {
	if (_defaults && key) {
		return [_defaults boolForKey:key];
	}
	else return NO;
}

- (BOOL)saveData:(id)object forKey:(NSString *)key {
	@synchronized(_defaults) {
		if (_defaults && key && object) {
			[_defaults setObject:object forKey:key];
		} else {
			[_defaults removeObjectForKey:key];
		}
		return [_defaults synchronize];
	}
}

- (BOOL)saveBoolData:(BOOL)object forKey:(NSString *)key {
	@synchronized(_defaults) {
		if (_defaults && key && object) {
			[_defaults setBool:object forKey:key];
		} else {
			[_defaults removeObjectForKey:key];
		}
		return [_defaults synchronize];
	}
}

@end
