//
//  DataController.h
//  DRST manager
//
//  Created by 김승호 on 2015. 11. 22..
//  Copyright © 2015년 Seungho Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataController : NSObject

@property (readonly) NSUserDefaults *defaults;
@property (readonly, copy) NSMutableArray *stamina_max;
@property (readonly, copy) NSMutableArray *stamina_current;
@property BOOL notification;
@property NSDate *date;
@property BOOL dualAccount;
- (void)setMaxStaminaAtIndex:(int)index withValue:(int) value;
- (int)maxStaminaAtIndex:(int)index;
- (void)setCurrentStaminaAtIndex:(int)index withValue:(int) value;
- (int)currentStaminaAtIndex:(int)index;
- (int)estimatedCurrentStaminaAtIndex:(int)index;
- (int)estimatedSecondLeftAtIndex:(int)index;
- (int)estimatedMinuteLeftAtIndex:(int)index;
- (void)registerNotifications;
- (void)releaseNotifications;
- (NSString *)estimatedTimeLeftStringAtIndex:(int)index;
- (NSString *)estimatedCompleteTimeStringAtIndex:(int)index;

@end
