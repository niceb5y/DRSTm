//
//  Stamina.swift
//  DRSTKit
//
//  Created by 김승호 on 2016. 1. 15..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit

public class DeviceData: NSObject, NSCoding {
	
	let version:Int = 0;
	
	var _level:Int = 1, _exp:Int = 0, _stamina:Int = 0
	
	public enum userGroup:Int {
		case A, B, C, D, E, F, G, H
	}
	
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
	
	var group:userGroup = userGroup.A;
	
	required public init?(coder aDecoder: NSCoder) {
		super.init()
		_level = aDecoder.decodeIntegerForKey("level")
		_exp = aDecoder.decodeIntegerForKey("exp")
		_stamina = aDecoder.decodeIntegerForKey("stamina")
		date = aDecoder.decodeObjectForKey("date") as! NSDate
		group = userGroup(rawValue: aDecoder.decodeIntegerForKey("group"))!
	}
	
	public init(level:Int, exp:Int, stamina:Int, date:NSDate, group:userGroup) {
		super.init()
		self.level = level
		self.exp = exp
		self.stamina = stamina
		self.date = date
		self.group = group
	}
	
	public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeInteger(version, forKey: "level")
		aCoder.encodeInteger(_level, forKey: "level")
		aCoder.encodeInteger(_exp, forKey: "exp")
		aCoder.encodeInteger(_stamina, forKey: "stamina")
		aCoder.encodeObject(date, forKey:"date")
		aCoder.encodeInteger(group.rawValue, forKey: "group")
	}
}
