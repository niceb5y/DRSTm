//
//  Data.Helper.swift
//  DRST manager
//
//  Created by 김승호 on 2016. 2. 9..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit

extension Data {
	
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
		
		/**
		Legacy data migration helper class for DRSTm
		- author: niceb5y
		*/
		class LegacyMigrator {
			@available(*, unavailable, message="Not implemented yet.")
			static func migrate() {
				//TODO: 마이그레이션 구현
			}
		}
	}
}