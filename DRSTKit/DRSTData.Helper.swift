//
//  Data.swift
//  DRST manager
//
//  Created by 김승호 on 2016. 2. 9..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit

extension DRSTData {
	
	/**
	User data managemant class for DRSTm
	- author: niceb5y
	*/
	open class Helper: NSObject {
		static let defaults = UserDefaults(suiteName: "group.com.niceb5y.drstm")!
		static let store = NSUbiquitousKeyValueStore.default()
		
		/**
		Load object from local NSUserDefaults
		- author: niceb5y
		- parameters:
		- key: Key of object
		- returns: Objects
		*/
		open static func loadObject(_ key: String) -> AnyObject? {
			let data = defaults.object(forKey: key) as! Data
			return NSKeyedUnarchiver.unarchiveObject(with: data) as AnyObject?
		}
		
		/**
		Load object from local NSUserDefaults or NSUbiquitousKeyValueStore
		- author: niceb5y
		- parameters:
		- key: Key of object
		- fromCloud: If data should loaded from iCloud
		- returns: Objects
		*/
		open static func loadObject(_ key: String, fromCloud: Bool) -> AnyObject? {
			if fromCloud {
				let data = store.object(forKey: key) as! Data
				return NSKeyedUnarchiver.unarchiveObject(with: data) as AnyObject?
			} else {
				return loadObject(key)
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
		open static func saveObject(_ value: AnyObject, forKey: String) -> Bool {
			let data = NSKeyedArchiver.archivedData(withRootObject: value)
			defaults.set(data, forKey: forKey)
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
		open static func saveObject(_ value: AnyObject, forKey: String, toCloud: Bool) -> Bool {
			var result = saveObject(value, forKey: forKey)
			if toCloud {
				let data = NSKeyedArchiver.archivedData(withRootObject: value)
				store.set(data, forKey: forKey)
				result = store.synchronize()
			}
			return result
		}
		
		/**
		Remove object from local NSUserDefaults
		- author: niceb5y
		- parameters:
		- key: Key of object
		- returns: If remove is success
		*/
		open static func removeObject(_ key: String) -> Bool {
			defaults.removeObject(forKey: key)
			return defaults.synchronize()
		}
		
		/**
		Remove object from local NSUserDefaults or NSUbiquitousKeyValueStore
		- author: niceb5y
		- parameters:
		- key: Key of object
		- fromCloud: If data should removed from iCloud
		- returns: If remove is Success
		*/
		open static func removeObject(_ key: String, fromCloud: Bool) -> Bool {
			var result = removeObject(key)
			if fromCloud {
				store.removeObject(forKey: key)
				result = store.synchronize()
			}
			return result
		}
		
		/**
		Load bool value from local NSUserDefaults
		- author: niceb5y
		- parameters:
		- key: Key of bool value
		- returns: Bool value
		*/
		open static func loadBool(_ key: String) -> Bool? {
			return defaults.bool(forKey: key)
		}
		
		/**
		Load bool value from local NSUserDefaults or NSUbiquitousKeyValueStore
		- author: niceb5y
		- parameters:
		- key: Key of bool value
		- returns: Bool value
		*/
		open static func loadBool(_ key: String, fromCloud: Bool) -> Bool? {
			if fromCloud {
				return store.bool(forKey: key)
			} else {
				return loadBool(key)
			}
		}
		
		/**
		Save bool value to local NSUserDefaults
		- author: niceb5y
		- parameters:
		- value: Bool value to save
		- forKey: Key of bool value
		- returns: If save is success
		*/
		open static func saveBool(_ value: Bool, forKey: String) -> Bool {
			defaults.set(value, forKey: forKey)
			return defaults.synchronize()
		}
		
		/**
		Save bool value to local NSUserDefaults or NSUbiquitousKeyValueStore
		- author: niceb5y
		- parameters:
		- value: Bool value to save
		- forKey: Key of bool value
		- toCloud: If data should saved to iCloud
		- returns: If save is success
		*/
		open static func saveBool(_ value: Bool, forKey: String, toCloud: Bool) -> Bool {
			var result = saveBool(value, forKey: forKey)
			if toCloud {
				store.set(value, forKey: forKey)
				result = store.synchronize()
			}
			return result
		}
		
		/**
		Legacy data migration helper class for DRSTm
		- author: niceb5y
		*/
		open class LegacyMigrator {
			@available(*, unavailable, message: "Not implemented yet.")
			static func migrate() {
				//TODO: 마이그레이션 구현
			}
		}
	}
}
