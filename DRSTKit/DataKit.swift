//
//  DataKit.swift
//  DRST manager
//
//  Created by 김승호 on 2015. 12. 5..
//  Copyright © 2015년 Seungho Kim. All rights reserved.
//

import UIKit

open class DataKit: NSObject {
	var defaults:UserDefaults
	var store:NSUbiquitousKeyValueStore
	
	
	public override init() {
		defaults = UserDefaults.init(suiteName: "group.com.niceb5y.drstm")!
		store =
			NSUbiquitousKeyValueStore.default()
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
			_ = saveData(staminaMax as AnyObject, forKey: "StaminaMax")
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
			_ = saveData(staminaCurrent as AnyObject, forKey: "StaminaCurrent")
		}
	}
	
	open func maxStamina(_ atIndex:Int) -> Int {
		return staminaMax[atIndex]
	}
	
	open func currentStamina(_ atIndex:Int) -> Int {
		return staminaCurrent[atIndex]
	}
	
	open func setMaxStamina(_ value:Int, atIndex:Int) {
		staminaMax[atIndex] = value
	}
	
	open func setCurrentStamina(_ value:Int, atIndex:Int) {
		staminaCurrent[atIndex] = value
	}
	
	open func estimatedCurrentStamina(_ atIndex:Int) -> Int {
		let interval:TimeInterval = Date.init().timeIntervalSince(self.date)
		return min(currentStamina(atIndex) + Int(interval) / 300, maxStamina(atIndex))
	}
	
	open func estimatedSecondLeft(_ atIndex:Int) -> Int {
		let interval:TimeInterval = Date.init().timeIntervalSince(self.date)
		let left = maxStamina(atIndex) - estimatedCurrentStamina(atIndex)
		return max(left * 300 - Int(interval) % 300, 0)
	}
	
	open func estimatedMinuteLeft(_ atIndex:Int) -> Int {
		return estimatedSecondLeft(atIndex) / 60
	}
	
	open func estimatedTimeLeftString(_ atIndex:Int) -> String {
		let minute = estimatedMinuteLeft(atIndex)
		if (minute > 59 && minute != 72) {
			return "\(minute / 60)시간 \(minute % 60)분"
		} else {
			return "\(minute)분"
		}
	}
	
	open func estimatedCompleteTimeString(_ atIndex:Int) -> String {
		let completeTime = Date.init(timeIntervalSinceNow: Double(estimatedSecondLeft(atIndex)))
		let dateFormatter = DateFormatter.init()
		dateFormatter.dateFormat = "a h시 mm분"
		return dateFormatter.string(from: completeTime)
	}
	
	open var dualAccountEnabled:Bool {
		get {
			let dualAccountEnabled = loadBoolData("SetDualAccount")
			if (dualAccountEnabled == nil) {
				return false
			}
			return dualAccountEnabled!
		}
		set(dualAccountEnabled) {
			_ = saveBoolData(dualAccountEnabled, forKey: "SetDualAccount")
		}
	}
	
	open var notificationEnabled:Bool {
		get {
			let notificationEnabled = loadBoolData("SetNotification")
			if (notificationEnabled == nil) {
				return false
			}
			return notificationEnabled!
		}
		set(notificationEnabled) {
			_ = saveBoolData(notificationEnabled, forKey: "SetNotification")
		}
	}
	
	open var iCloudEnabled:Bool {
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
				_ = saveBoolData(iCloudEnabled, forKey: "SetiCloudEnabled")
				notificationEnabled = _notification
				dualAccountEnabled = _dualAccount
				date = _date
				staminaMax = _staminaMax
				staminaCurrent = _staminaCurrent
			} else {
				_ = saveBoolData(iCloudEnabled, forKey: "SetiCloudEnabled")
			}
		}
	}
	
	open var date:Date {
		get {
			let date = loadData("SetDate")
			if (date == nil) {
				return Date.init()
			}
			return date as! Date
		}
		set(date) {
			_ = saveData(date as AnyObject, forKey: "SetDate")
		}
	}
	
	func loadData(_ key:String) -> AnyObject? {
		if (iCloudEnabled) {
			return store.object(forKey: key) as AnyObject?
		} else {
			return loadLocalData(key)
		}
	}
	
	func loadBoolData(_ key:String) -> Bool? {
		if (iCloudEnabled) {
			return store.bool(forKey: key)
		} else {
			return loadLocalBoolData(key)
		}
	}
	
	func saveData(_ value:AnyObject, forKey:String) -> Bool? {
		if (iCloudEnabled) {
			store.set(value, forKey: forKey)
			_ = saveLocalData(value, forKey: forKey)
			return store.synchronize()
		} else {
			return saveLocalData(value, forKey: forKey)
		}
	}
	
	func saveBoolData(_ value:Bool, forKey:String) -> Bool? {
		if (iCloudEnabled) {
			store.set(value, forKey: forKey)
			_ = saveLocalBoolData(value, forKey: forKey)
			return store.synchronize()
		} else {
			return saveLocalBoolData(value, forKey: forKey)
		}
	}
	
	func loadLocalData(_ key:String) -> AnyObject? {
		return defaults.object(forKey: key) as AnyObject?
	}
	
	func loadLocalBoolData(_ key:String) -> Bool? {
		return defaults.bool(forKey: key)
	}
	
	func saveLocalData(_ value:AnyObject, forKey:String) -> Bool? {
		defaults.set(value, forKey: forKey)
		return defaults.synchronize()
	}
	
	func saveLocalBoolData(_ value:Bool, forKey:String) -> Bool? {
		defaults.set(value, forKey: forKey)
		return defaults.synchronize()
	}
}
