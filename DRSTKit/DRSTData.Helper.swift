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
	public class Helper: NSObject {
		static let defaults = NSUserDefaults(suiteName: "group.com.niceb5y.drstm")!
		static let store = NSUbiquitousKeyValueStore.defaultStore()
		
		/**
		Load object from local NSUserDefaults
		- author: niceb5y
		- parameters:
		- key: Key of object
		- returns: Objects
		*/
		public static func loadObject(key: String) -> AnyObject? {
			let data = defaults.objectForKey(key) as! NSData
			return NSKeyedUnarchiver.unarchiveObjectWithData(data)
		}
		
		/**
		Load object from local NSUserDefaults or NSUbiquitousKeyValueStore
		- author: niceb5y
		- parameters:
		- key: Key of object
		- fromCloud: If data should loaded from iCloud
		- returns: Objects
		*/
		public static func loadObject(key: String, fromCloud: Bool) -> AnyObject? {
			if fromCloud {
				let data = store.objectForKey(key) as! NSData
				return NSKeyedUnarchiver.unarchiveObjectWithData(data)
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
		public static func saveObject(value: AnyObject, forKey: String) -> Bool {
			let data = NSKeyedArchiver.archivedDataWithRootObject(value)
			defaults.setObject(data, forKey: forKey)
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
		public static func saveObject(value: AnyObject, forKey: String, toCloud: Bool) -> Bool {
			var result = saveObject(value, forKey: forKey)
			if toCloud {
				let data = NSKeyedArchiver.archivedDataWithRootObject(value)
				store.setObject(data, forKey: forKey)
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
		public static func removeObject(key: String) -> Bool {
			defaults.removeObjectForKey(key)
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
		public static func removeObject(key: String, fromCloud: Bool) -> Bool {
			var result = removeObject(key)
			if fromCloud {
				store.removeObjectForKey(key)
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
		public static func loadBool(key: String) -> Bool? {
			return defaults.boolForKey(key)
		}
		
		/**
		Load bool value from local NSUserDefaults or NSUbiquitousKeyValueStore
		- author: niceb5y
		- parameters:
		- key: Key of bool value
		- returns: Bool value
		*/
		public static func loadBool(key: String, fromCloud: Bool) -> Bool? {
			if fromCloud {
				return store.boolForKey(key)
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
		public static func saveBool(value: Bool, forKey: String) -> Bool {
			defaults.setBool(value, forKey: forKey)
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
		public static func saveBool(value: Bool, forKey: String, toCloud: Bool) -> Bool {
			var result = saveBool(value, forKey: forKey)
			if toCloud {
				store.setBool(value, forKey: forKey)
				result = store.synchronize()
			}
			return result
		}
		
		/**
		Legacy data migration helper class for DRSTm
		- author: niceb5y
		*/
		public class LegacyMigrator {
			@available(*, unavailable, message="Not implemented yet.")
			static func migrate() {
				//TODO: 마이그레이션 구현
			}
		}
	}
}