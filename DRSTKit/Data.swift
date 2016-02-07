//
//  Data.swift
//  DRST manager
//
//  Created by 김승호 on 2016. 2. 6..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit

public class Data: NSObject {
	
	public enum UserGroup: Int {
		case A, B, C, D, E, F, G, H
	}
	
	public enum SongLevel: Int {
		case Debut, Regular, Pro, Master
	}
	
	var deviceData: Array<Device> {
		get {
			var _deviceData = Helper.loadObject("DeviceData", fromCloud: notificationEnabled) as? Array<Device>
			if _deviceData == nil {
				_deviceData = Array<Device>()
				_deviceData?.append(Device())
			}
			return _deviceData!
		}
		
		set(deviceData) {
			Helper.saveObject(deviceData, forKey: "DeviceData", toCloud: notificationEnabled)
		}
	}
	
	var notificationEnabled: Bool {
		get {
			var _notificationEnabled: Bool? = Helper.loadBool("NotificationEnabled")
			if _notificationEnabled == nil {
				_notificationEnabled = false
			}
			return _notificationEnabled!
		}
		
		set(notificationEnabled) {
			Helper.saveBool(notificationEnabled, forKey: "NotificationEnabled")
		}
	}
	
	public class Device: NSObject, NSCoding {
		let version: Int = 0
		
		var _level: Int = 1, _exp: Int = 0, _stamina: Int = 0
		
		public var level: Int {
			get {
				return _level
			}
			set(level) {
				if level < 1 || level > 150 {
					_level = 1
				} else {
					_level = level
				}
			}
		}
		
		public var exp: Int {
			get {
				return _exp
			}
			set(exp) {
				if level < 0 || level > expMax {
					_exp = 0
				} else {
					_exp = exp
				}
			}
		}
		
		public var expMax: Int {
			get {
				return EXP.expAtLevel(level)
			}
		}
		
		var stamina: Int {
			get {
				return _stamina
			}
			set(stamina) {
				if stamina < 0 || stamina > staminaMax {
					_stamina = 0
				} else {
					_stamina = stamina
				}
			}
		}
		
		var staminaMax: Int {
			get {
				return Stamina.staminaAtLevel(level)
			}
		}
		
		var date: NSDate = NSDate.init()
		
		var group: UserGroup = UserGroup.A
		
		var preferLevel = SongLevel.Debut
		
		var preferEventLevel = SongLevel.Debut
		
		public override init() {
			super.init()
		}
		
		public required init?(coder aDecoder: NSCoder) {
			super.init()
			_level = aDecoder.decodeIntegerForKey("level")
			_exp = aDecoder.decodeIntegerForKey("exp")
			_stamina = aDecoder.decodeIntegerForKey("stamina")
			date = aDecoder.decodeObjectForKey("date") as! NSDate
			group = UserGroup(rawValue: aDecoder.decodeIntegerForKey("group"))!
			preferLevel = SongLevel(rawValue: aDecoder.decodeIntegerForKey("preferLevel"))!
			preferEventLevel = SongLevel(rawValue: aDecoder.decodeIntegerForKey("preferEventLevel"))!
		}

		
		public func encodeWithCoder(aCoder: NSCoder) {
			aCoder.encodeInteger(version, forKey: "version")
			aCoder.encodeInteger(_level, forKey: "level")
			aCoder.encodeInteger(_exp, forKey: "exp")
			aCoder.encodeInteger(_stamina, forKey: "stamina")
			aCoder.encodeObject(date, forKey: "date")
			aCoder.encodeInteger(group.rawValue, forKey: "group")
			aCoder.encodeInteger(preferLevel.rawValue, forKey: "preferLevel")
			aCoder.encodeInteger(preferEventLevel.rawValue, forKey: "preferEventLevel")
		}
	}
	
	class Helper: NSObject {
		static let defaults = NSUserDefaults(suiteName: "group.com.niceb5y.drstm")!
		static let store = NSUbiquitousKeyValueStore.defaultStore()
		
		static func saveObject(value: AnyObject, forKey: String) -> Bool? {
			defaults.setObject(value, forKey: forKey)
			return defaults.synchronize()
		}
		
		static func loadObject(key: String) -> AnyObject? {
			return defaults.objectForKey(key)
		}
		
		static func saveBool(value: Bool, forKey: String) -> Bool? {
			defaults.setBool(value, forKey: forKey)
			return defaults.synchronize()
		}
		
		static func loadBool(key: String) -> Bool? {
			return defaults.boolForKey(key)
		}
		
		static func saveObject(value: AnyObject, forKey: String, toCloud: Bool) -> Bool? {
			var result = Helper.saveObject(value, forKey: forKey)
			if toCloud {
				store.setObject(value, forKey: forKey)
				result = store.synchronize()
			}
			return result
		}
		
		static func loadObject(key: String, fromCloud: Bool) -> AnyObject? {
			if fromCloud {
				return store.objectForKey(key)
			} else {
				return self.loadObject(key)
			}
		}
		
		static func saveBool(value: Bool, forKey: String, toCloud: Bool) -> Bool? {
			var result = Helper.saveBool(value, forKey: forKey)
			if toCloud {
				store.setBool(value, forKey: forKey)
				result = store.synchronize()
			}
			return result
		}
		
		static func loadBool(key: String, fromCloud: Bool) -> Bool? {
			if fromCloud {
				return store.boolForKey(key)
			} else {
				return self.loadBool(key)
			}
		}
	}
	
	public class LegacyMigrator {
		public func migrate() {
			//TODO: 마이그레이션 구현
		}
	}
}