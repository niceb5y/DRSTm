//
//  DataKit.swift
//  DRST manager
//
//  Created by 김승호 on 2015. 12. 5..
//  Copyright © 2015년 Seungho Kim. All rights reserved.
//

import UIKit

public class DataKit: NSObject {
	var defaults:NSUserDefaults
	var store:NSUbiquitousKeyValueStore
	
	
	public override init() {
		defaults = NSUserDefaults.init(suiteName: "group.com.niceb5y.drstm")!
		store =
			NSUbiquitousKeyValueStore.defaultStore()
		super.init()
	}
	
	var staminaMax:Array<Int> {
		get {
			let staminaMax = loadData("StaminaMax")
			if (staminaMax == nil) {
				return [40, 40]
			}
			return staminaMax as! Array<Int>
		}
		set(staminaMax) {
			saveData(staminaMax, forKey: "StaminaMax")
		}
	}
	
	var staminaCurrent:Array<Int>  {
		get {
			let staminaCurrent = loadData("StaminaCurrent")
			if (staminaCurrent == nil) {
				return [0, 0]
			}
			return staminaCurrent as! Array<Int>
		}
		set(staminaCurrent) {
			saveData(staminaCurrent, forKey: "StaminaCurrent")
		}
	}
	
	public func maxStamina(atIndex:Int) -> Int {
		return staminaMax[atIndex]
	}
	
	public func currentStamina(atIndex:Int) -> Int {
		return staminaCurrent[atIndex]
	}
	
	public func setMaxStamina(value:Int, atIndex:Int) {
		staminaMax[atIndex] = value
	}
	
	public func setCurrentStamina(value:Int, atIndex:Int) {
		staminaCurrent[atIndex] = value
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
