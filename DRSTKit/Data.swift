//
//  Data.swift
//  DRST manager
//
//  Created by 김승호 on 2016. 2. 6..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit

public class Data: NSObject {
	
	enum UserGroup:Int {
		case A, B, C, D, E, F, G, H
	}
	
	enum PreferLevel:Int {
		case Debut, Regular, Pro, Master
	}
	
	//TODO:인터페이스 구현
	class Device: NSObject, NSCoding {
		let version:Int = 0;
		var _level:Int = 1, _exp:Int = 0, _stamina:Int = 0
		
		var level:Int {
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
		
		var exp:Int {
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
		
		var expMax:Int {
			get {
				return EXP.expAtLevel(level)
			}
		}
		
		var stamina:Int {
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
		
		var staminaMax:Int {
			get {
				return Stamina.staminaAtLevel(level);
			}
		}
		
		var date:NSDate = NSDate.init()
		
		var group:UserGroup = UserGroup.A;
		
		init(level:Int, exp:Int, stamina:Int, date:NSDate, group:UserGroup) {
			super.init()
			self.level = level
			self.exp = exp
			self.stamina = stamina
			self.date = date
			self.group = group
		}
		
		required init?(coder aDecoder: NSCoder) {
			super.init()
			_level = aDecoder.decodeIntegerForKey("level")
			_exp = aDecoder.decodeIntegerForKey("exp")
			_stamina = aDecoder.decodeIntegerForKey("stamina")
			date = aDecoder.decodeObjectForKey("date") as! NSDate
			group = UserGroup(rawValue: aDecoder.decodeIntegerForKey("group"))!
		}

		
		func encodeWithCoder(aCoder: NSCoder) {
			aCoder.encodeInteger(version, forKey: "version")
			aCoder.encodeInteger(_level, forKey: "level")
			aCoder.encodeInteger(_exp, forKey: "exp")
			aCoder.encodeInteger(_stamina, forKey: "stamina")
			aCoder.encodeObject(date, forKey:"date")
			aCoder.encodeInteger(group.rawValue, forKey: "group")
		}
	}
	
	class Helper: NSObject {
		static let defaults = NSUserDefaults(suiteName:"group.com.niceb5y.drstm")!
		static let store = NSUbiquitousKeyValueStore.defaultStore()
		
		static func saveObject(value:AnyObject, forKey:String) -> Bool? {
			defaults.setObject(value, forKey: forKey)
			return defaults.synchronize()
		}
		
		static func loadObject(key:String) -> AnyObject? {
			return defaults.objectForKey(key)
		}
		
		static func saveBool(value:Bool, forKey: String) -> Bool? {
			defaults.setBool(value, forKey: forKey)
			return defaults.synchronize()
		}
		
		static func loadBool(key:String) -> Bool? {
			return defaults.boolForKey(key)
		}
		
		static func saveObject(value:AnyObject, forKey:String, toCloud:Bool) -> Bool? {
			var result = Helper.saveObject(value, forKey: forKey)
			if toCloud {
				store.setObject(value, forKey: forKey)
				result = store.synchronize()
			}
			return result
		}
		
		static func loadObject(key:String, fromCloud:Bool) -> AnyObject? {
			if fromCloud {
				return store.objectForKey(key)
			} else {
				return self.loadObject(key)
			}
		}
		
		static func saveBool(value:Bool, forKey: String, toCloud:Bool) -> Bool? {
			var result = Helper.saveBool(value, forKey: forKey)
			if toCloud {
				store.setBool(value, forKey: forKey)
				result = store.synchronize()
			}
			return result
		}
		
		static func loadBool(key:String, fromCloud:Bool) -> Bool? {
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