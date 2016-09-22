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
	open class Device: NSObject, NSCoding {
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
		open var level: Int {
			get {
				return _level
			}
			set(level) {
				if level < 1 || level > 300 {
					_level = 1
				} else {
					_level = level
				}
			}
		}
		
		/**
		Current deresute EXP
		*/
		open var exp: Int {
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
		open var expMax: Int {
			get {
				return DRSTEXP.expAtLevel(level)
			}
		}
		
		/**
		Current deresute stamina
		*/
		open var stamina: Int {
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
		open var staminaMax: Int {
			get {
				return DRSTStamina.staminaAtLevel(level)
			}
		}
		
		/**
		Edited Date
		*/
		open var date: Date = Date.init()
		
		/**
		Deresute user group
		*/
		open var group: UserGroup = UserGroup.a
		
		/**
		Preferred deresute song level
		*/
		open var preferLevel = SongLevel.debut
		
		/**
		Preferred deresute event song level
		*/
		open var preferEventLevel = SongLevel.debut
		
		public override init() {
			super.init()
		}
		
		public required init?(coder aDecoder: NSCoder) {
			super.init()
			_level = aDecoder.decodeInteger(forKey: "level")
			_exp = aDecoder.decodeInteger(forKey: "exp")
			_stamina = aDecoder.decodeInteger(forKey: "stamina")
			date = aDecoder.decodeObject(forKey: "date") as! Date
			group = UserGroup(rawValue: aDecoder.decodeInteger(forKey: "group"))!
			preferLevel = SongLevel(rawValue: aDecoder.decodeInteger(forKey: "preferLevel"))!
			preferEventLevel = SongLevel(rawValue: aDecoder.decodeInteger(forKey: "preferEventLevel"))!
		}
		
		
		open func encode(with aCoder: NSCoder) {
			aCoder.encode(version, forKey: "version")
			aCoder.encode(_level, forKey: "level")
			aCoder.encode(_exp, forKey: "exp")
			aCoder.encode(_stamina, forKey: "stamina")
			aCoder.encode(date, forKey: "date")
			aCoder.encode(group.rawValue, forKey: "group")
			aCoder.encode(preferLevel.rawValue, forKey: "preferLevel")
			aCoder.encode(preferEventLevel.rawValue, forKey: "preferEventLevel")
		}
	}
}
