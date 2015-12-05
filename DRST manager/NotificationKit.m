//
//  NotificationKit.m
//  DRST manager
//
//  Created by 김승호 on 2015. 12. 5..
//  Copyright © 2015년 Seungho Kim. All rights reserved.
//

#import "NotificationKit.h"

@implementation NotificationKit

+ (void)registerNotification {
	[self clearNotification];
	int loop = 1;
	DataKit *dk = [[DataKit alloc] init];
	if (dk.dualAccountEnabled) {
		loop = 2;
	}
	for (int i = 0; i < loop; i++) {
		UILocalNotification *noti = [[UILocalNotification alloc] init];
		noti.fireDate = [NSDate dateWithTimeIntervalSinceNow:[dk estimatedSecondLeft:i]];
		if (loop == 2) {
			noti.alertBody = [NSString stringWithFormat:@"[기기 %d]스태미너가 가득 찼습니다.", i + 1];
		} else {
			noti.alertBody = @"스태미너가 가득 찼습니다.";
		}
		noti.alertTitle = @"DRSTm";
		noti.soundName = UILocalNotificationDefaultSoundName;
		[[UIApplication sharedApplication] scheduleLocalNotification:noti];
	}
}

+ (void)clearNotification {
	[[UIApplication sharedApplication] cancelAllLocalNotifications];
}

@end
