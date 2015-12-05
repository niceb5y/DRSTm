//
//  NotificationKit.h
//  DRST manager
//
//  Created by 김승호 on 2015. 12. 5..
//  Copyright © 2015년 Seungho Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@import DRSTDataKit;
@class DataKit;

@interface NotificationKit : NSObject

+ (void)registerNotification;
+ (void)clearNotification;

@end
