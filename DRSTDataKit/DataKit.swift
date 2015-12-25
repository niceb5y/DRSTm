//
//  DataKit.swift
//  DRST manager
//
//  Created by 김승호 on 2015. 12. 5..
//  Copyright © 2015년 Seungho Kim. All rights reserved.
//

import UIKit

@objc public class DataKit: NSObject {
	var defaults:NSUserDefaults
	var store:NSUbiquitousKeyValueStore
	
	let EXP:NSArray = [-1, 30, 50, 70, 90, 110, 130, 150, 170, 190, 210, 230, 250, 270, 290, 310, 330, 350, 370, 390, 410, 430, 450, 470, 490, 510, 530, 550, 570, 590, 610, 630, 650, 670, 690, 710, 730, 750, 770, 790, 810, 830, 850, 870, 890, 910, 930, 950, 970, 990, 1500, 1520, 1540, 1560, 1580, 1600, 1620, 1640, 1660, 1680, 1700, 1720, 1740, 1760, 1780, 1800, 1820, 1840, 1860, 1880, 1900, 1920, 1940, 1960, 1980, 2000, 2020, 2040, 2060, 2080, 2100, 2120, 2140, 2160, 2180, 2200, 2220, 2240, 2260, 2280, 2300, 2320, 2340, 2360, 2380, 2400, 2420, 2440, 2460, 2480, 3000, 3020, 3040, 3060, 3080, 3100, 3120, 3140, 3160, 3180, 3200, 3220, 3240, 3260, 3280, 3300, 3320, 3340, 3360, 3380, 3400, 3420, 3440, 3460, 3480, 3500, 3520, 3540, 3560, 3580, 3600, 3620, 3640, 3660, 3680, 3700, 3720, 3740, 3760, 3780, 3800, 3820, 3840, 3860, 3880, 3900, 3920, 3940, 3960, 3980, 0]
	
	let STAMINA:NSArray = [-1, 40, 41, 41, 42, 42, 43, 43, 44, 44, 45, 45, 46, 46, 47, 47, 48, 48, 49, 49, 50, 50, 50, 51, 51, 51, 52, 52, 52, 53, 53, 53, 54, 54, 54, 55, 55, 55, 56, 56, 56, 57, 57, 57, 58, 58, 58, 59, 59, 59, 60, 60, 60, 60, 61, 61, 61, 61, 62, 62, 62, 62, 63, 63, 63, 63, 64, 64, 64, 64, 65, 65, 65, 65, 66, 66, 66, 66, 67, 67, 67, 67, 68, 68, 68, 68, 69, 69, 69, 69, 70, 70, 70, 70, 70, 71, 71, 71, 71, 71, 72, 72, 72, 72, 72, 73, 73, 73, 73, 73, 74, 74, 74, 74, 74, 75, 75, 75, 75, 75, 76, 76, 76, 76, 76, 77, 77, 77, 77, 77, 78, 78, 78, 78, 78, 79, 79, 79, 79, 79, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 81]
	
	override init() {
		defaults = NSUserDefaults.init(suiteName: "group.com.niceb5y.drstm")!
		store =
			NSUbiquitousKeyValueStore.defaultStore()
	}
	
	var staminaMax:NSArray {
		get {
			let staminaMax = loadData("StaminaMax")
			if (staminaMax == nil) {
				return [40, 40]
			}
			return staminaMax as! NSArray
		}
		set(staminaMax) {
			saveData(staminaMax, forKey: "StaminaMax")
		}
	}
	
	var staminaCurrent:NSArray  {
		get {
			let staminaCurrent = loadData("StaminaCurrent")
			if (staminaCurrent == nil) {
				return [0, 0]
			}
			return staminaCurrent as! NSArray
		}
		set(staminaCurrent) {
			saveData(staminaCurrent, forKey: "StaminaCurrent")
		}
	}
	
	public func maxStamina(atIndex:Int) -> Int {
		return staminaMax.objectAtIndex(atIndex) as! Int
	}
	
	public func currentStamina(atIndex:Int) -> Int {
		return staminaCurrent.objectAtIndex(atIndex) as! Int
	}
	
	public func setMaxStamina(value:Int, atIndex:Int) {
		let stamina = staminaMax.mutableCopy() as! NSMutableArray
		stamina.replaceObjectAtIndex(max(min(atIndex, 1), 0), withObject: value)
		staminaMax = stamina
	}
	
	public func setCurrentStamina(value:Int, atIndex:Int) {
		let stamina = staminaCurrent.mutableCopy() as! NSMutableArray
		stamina.replaceObjectAtIndex(max(min(atIndex, 1), 0), withObject: value)
		staminaCurrent = stamina
	}
	
	public func estimatedCurrentStamina(atIndex:Int) -> Int {
		let interval:NSTimeInterval = NSDate.init().timeIntervalSinceDate(self.date)
		return min(currentStamina(atIndex) + Int(interval) / 300, maxStamina(atIndex))
	}
	
	public func estimatedSecondLeft(atIndex:Int) -> Int {
		let interval:NSTimeInterval = NSDate.init().timeIntervalSinceDate(self.date)
		let left = maxStamina(atIndex) - estimatedCurrentStamina(atIndex)
		return max(left * 300 - Int(interval) % 300, 0)
	}
	
	public func estimatedMinuteLeft(atIndex:Int) -> Int {
		return estimatedSecondLeft(atIndex) / 60
	}
	
	public func estimatedTimeLeftString(atIndex:Int) -> String {
		let minute = estimatedMinuteLeft(atIndex)
		if (minute > 59 && minute != 72) {
			return "\(minute / 60)시간 \(minute % 60)분"
		} else {
			return "\(minute)분"
		}
	}
	
	public func estimatedCompleteTimeString(atIndex:Int) -> String {
		let completeTime = NSDate.init(timeIntervalSinceNow: Double(estimatedSecondLeft(atIndex)))
		let dateFormatter = NSDateFormatter.init()
		dateFormatter.dateFormat = "a h시 mm분"
		return dateFormatter.stringFromDate(completeTime)
	}
	
	public var dualAccountEnabled:Bool {
		get {
			let dualAccountEnabled = loadBoolData("SetDualAccount")
			if (dualAccountEnabled == nil) {
				return false
			}
			return dualAccountEnabled!
		}
		set(dualAccountEnabled) {
			saveBoolData(dualAccountEnabled, forKey: "SetDualAccount")
		}
	}
	
	public var notificationEnabled:Bool {
		get {
			let notificationEnabled = loadBoolData("SetNotification")
			if (notificationEnabled == nil) {
				return false
			}
			return notificationEnabled!
		}
		set(notificationEnabled) {
			saveBoolData(notificationEnabled, forKey: "SetNotification")
		}
	}
	
	public var iCloudEnabled:Bool {
		get {
			let iCloudEnabled = loadLocalBoolData("SetiCloudEnabled")
			if (iCloudEnabled == nil) {
				return false
			}
			return iCloudEnabled!
		}
		set(iCloudEnabled) {
			if (iCloudEnabled) {
				let _notification = notificationEnabled
				let _dualAccount = dualAccountEnabled
				let _date = date
				let _staminaMax = staminaMax
				let _staminaCurrent = staminaCurrent
				saveBoolData(iCloudEnabled, forKey: "SetiCloudEnabled")
				notificationEnabled = _notification
				dualAccountEnabled = _dualAccount
				date = _date
				staminaMax = _staminaMax
				staminaCurrent = _staminaCurrent
			} else {
				saveBoolData(iCloudEnabled, forKey: "SetiCloudEnabled")
			}
		}
	}
	
	public var date:NSDate {
		get {
			let date = loadData("SetDate")
			if (date == nil) {
				return NSDate.init()
			}
			return date as! NSDate
		}
		set(date) {
			saveData(date, forKey: "SetDate")
		}
	}
	
	func loadData(key:String) -> AnyObject? {
		if (iCloudEnabled) {
			return store.objectForKey(key)
		} else {
			return loadLocalData(key)
		}
	}
	
	func loadBoolData(key:String) -> Bool? {
		if (iCloudEnabled) {
			return store.boolForKey(key)
		} else {
			return loadLocalBoolData(key)
		}
	}
	
	func saveData(value:AnyObject, forKey:String) -> Bool? {
		if (iCloudEnabled) {
			store.setObject(value, forKey: forKey)
			saveLocalData(value, forKey: forKey)
			return store.synchronize()
		} else {
			return saveLocalData(value, forKey: forKey)
		}
	}
	
	func saveBoolData(value:Bool, forKey:String) -> Bool? {
		if (iCloudEnabled) {
			store.setBool(value, forKey: forKey)
			saveLocalBoolData(value, forKey: forKey)
			return store.synchronize()
		} else {
			return saveLocalBoolData(value, forKey: forKey)
		}
	}
	
	func loadLocalData(key:String) -> AnyObject? {
		return defaults.objectForKey(key)
	}
	
	func loadLocalBoolData(key:String) -> Bool? {
		return defaults.boolForKey(key)
	}
	
	func saveLocalData(value:AnyObject, forKey:String) -> Bool? {
		defaults.setObject(value, forKey: forKey)
		return defaults.synchronize()
	}
	
	func saveLocalBoolData(value:Bool, forKey:String) -> Bool? {
		defaults.setBool(value, forKey: forKey)
		return defaults.synchronize()
	}
}
