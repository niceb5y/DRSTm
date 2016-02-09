//
//  Data.Device.swift
//  DRST manager
//
//  Created by 김승호 on 2016. 2. 9..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit

extension DRSTData {
	
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
				return DRSTEXP.expAtLevel(level)
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
				return DRSTStamina.staminaAtLevel(level)
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
}