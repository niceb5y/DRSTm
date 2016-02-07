//
//  Data.swift
//  DRST manager
//
//  Created by 김승호 on 2016. 2. 6..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit

/**
User data for DRSTm
- author: niceb5y
*/
public class Data: NSObject {
	
	/**
	User group of deresute account.
	* Group A ~ H
	*/
	public enum UserGroup: Int {
		case A, B, C, D, E, F, G, H
	}
	
	/**
	Level of deresute songs.
	* Debut
	* Regular
	* Pro
	* Master
	*/
	public enum SongLevel: Int {
		case Debut, Regular, Pro, Master
	}
	
	/**
	Array of user device data.
	*/
	public var deviceData: Array<Device> {
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
	
	/**
	If notification is enabled by user.
	*/
	public var notificationEnabled: Bool {
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
	
	/**
	User device data for DRSTm
	- author: niceb5y
	*/
	public class Device: NSObject, NSCoding {
		/**
		Current version of object
		*/
		let version: Int = 0
		
		/**
		Internal variables
		*/
		var _level: Int = 1, _exp: Int = 0, _stamina: Int = 0
		
		/**
		Deresute level
		*/
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
		
		/**
		Current deresute EXP
		*/
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
		
		/**
		Maximum deresute EXP
		*/
		public var expMax: Int {
			get {
				return EXP.expAtLevel(level)
			}
		}
		
		/**
		Current deresute stamina
		*/
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
		
		/**
		Maximum deresute stamina
		*/
		var staminaMax: Int {
			get {
				return Stamina.staminaAtLevel(level)
			}
		}
		
		/**
		Edited Date
		*/
		var date: NSDate = NSDate.init()
		
		/**
		Deresute user group
		*/
		var group: UserGroup = UserGroup.A
		
		/**
		Preferred deresute song level
		*/
		var preferLevel = SongLevel.Debut
		
		/**
		Preferred deresute event song level
		*/
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
	
	/**
	User data managemant class for DRSTm
	- author: niceb5y
	*/
	class Helper: NSObject {
		static let defaults = NSUserDefaults(suiteName: "group.com.niceb5y.drstm")!
		static let store = NSUbiquitousKeyValueStore.defaultStore()
		
		
		/**
		Load object from local NSUserDefaults
		- author: niceb5y
		- parameters:
			- key: Key of object
		- returns: Objects
		*/
		static func loadObject(key: String) -> AnyObject? {
			return defaults.objectForKey(key)
		}
		
		/**
		Load object from local NSUserDefaults or NSUbiquitousKeyValueStore
		- author: niceb5y
		- parameters:
			- key: Key of object
			- fromCloud: If data should loaded from iCloud
		- returns: Objects
		*/
		static func loadObject(key: String, fromCloud: Bool) -> AnyObject? {
			if fromCloud {
				return store.objectForKey(key)
			} else {
				return self.loadObject(key)
			}
		}
		
		/**
		Save object to local NSUserDefaults
		- author: niceb5y
		- parameters:
			- value: Object to save
			- forKey: Key of object
		- returns: If save is success
		*/
		static func saveObject(value: AnyObject, forKey: String) -> Bool? {
			defaults.setObject(value, forKey: forKey)
			return defaults.synchronize()
		}

		/**
		Save object to local NSUserDefaults or NSUbiquitousKeyValueStore
		- author: niceb5y
		- parameters:
			- value: Object to save
			- forKey: Key of object
			- toCloud: If data should saved to iCloud
		- returns: If save is success
		*/
		static func saveObject(value: AnyObject, forKey: String, toCloud: Bool) -> Bool? {
			var result = Helper.saveObject(value, forKey: forKey)
			if toCloud {
				store.setObject(value, forKey: forKey)
				result = store.synchronize()
			}
			return result
		}
		
		/**
		Load bool value from local NSUserDefaults
		- author: niceb5y
		- parameters:
			- key: Key of object
		- returns: Bool value
		*/
		static func loadBool(key: String) -> Bool? {
			return defaults.boolForKey(key)
		}
		
		/**
		Load bool value from local NSUserDefaults or NSUbiquitousKeyValueStore
		- author: niceb5y
		- parameters:
			- key: Key of object
		- returns: Bool value
		*/
		static func loadBool(key: String, fromCloud: Bool) -> Bool? {
			if fromCloud {
				return store.boolForKey(key)
			} else {
				return self.loadBool(key)
			}
		}
		
		/**
		Save bool value to local NSUserDefaults
		- author: niceb5y
		- parameters:
			- value: Bool value to save
			- forKey: Key of value
		- returns: If save is success
		*/
		static func saveBool(value: Bool, forKey: String) -> Bool? {
			defaults.setBool(value, forKey: forKey)
			return defaults.synchronize()
		}
		
		/**
		Save bool value to local NSUserDefaults or NSUbiquitousKeyValueStore
		- author: niceb5y
		- parameters:
			- value: Bool value to save
			- forKey: Key of value
			- toCloud: If data should saved to iCloud
		- returns: If save is success
		*/
		static func saveBool(value: Bool, forKey: String, toCloud: Bool) -> Bool? {
			var result = Helper.saveBool(value, forKey: forKey)
			if toCloud {
				store.setBool(value, forKey: forKey)
				result = store.synchronize()
			}
			return result
		}
		
	}
	
	public class LegacyMigrator {
		@available(*, unavailable, message="Not implemented yet.")
		public static func migrate() {
			//TODO: 마이그레이션 구현
		}
	}
}