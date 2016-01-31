//
//  DRSTNotification.swift
//  DRST manager
//
//  Created by 김승호 on 2016. 1. 30..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit
import DRSTKit

/**
Notification helper class for DRST manager
- author: niceb5y
*/
class DRSTNotification: NSObject {
	
	/**
	Register notification(s)
	- author: niceb5y
	*/
	static func register() {
		self.clear()
		let dk = DataKit()
		let loop = dk.dualAccountEnabled ? 2 : 1
		for index in 0 ..< loop {
			let noti = UILocalNotification()
			noti.fireDate = NSDate(timeIntervalSinceNow: NSTimeInterval(dk.estimatedSecondLeft(index)))
			if loop == 2 {
				noti.alertBody = "[기기 \(index)] 스태미너가 가득 찼습니다."
			} else {
				noti.alertBody = "스태미너가 가득 찼습니다."
			}
			noti.alertTitle = "DRSTm"
			noti.soundName = UILocalNotificationDefaultSoundName;
			UIApplication.sharedApplication().scheduleLocalNotification(noti)
		}
	}
	
	/**
	Clear notification(s)
	- author: niceb5y
	*/
	static func clear() {
		UIApplication.sharedApplication().cancelAllLocalNotifications()
	}
}
