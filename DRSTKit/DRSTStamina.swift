//
//  StaminaKit.swift
//  DRSTKit
//
//  Created by 김승호 on 2016. 1. 15..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit

/**
Deresute Stamina Data
- author: niceb5y
*/
public class DRSTStamina: NSObject {
	static let stamina: Array<Int> = [40, 41, 41, 42, 42, 43, 43, 44, 44, 45, 45, 46, 46, 47, 47, 48, 48,  49, 49, 50, 50, 50, 51, 51, 51, 52, 52, 52, 53, 53, 53, 54, 54, 54, 55, 55, 55, 56, 56, 56, 57, 57, 57, 58, 58, 58, 59, 59, 59, 60, 60, 60, 60, 61, 61, 61, 61, 62, 62, 62, 62, 63, 63, 63, 63, 64, 64, 64, 64, 65, 65, 65, 65, 66, 66, 66, 66, 67, 67, 67, 67, 68, 68, 68, 68, 69, 69, 69, 69, 70, 70, 70, 70, 70, 71, 71, 71, 71, 71, 72, 72, 72, 72, 72, 73, 73, 73, 73, 73, 74, 74, 74, 74, 74, 75, 75, 75, 75, 75, 76, 76, 76, 76, 76, 77, 77, 77, 77, 77, 78, 78, 78, 78, 78, 79, 79, 79, 79, 79, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 81]
	
	/**
	Stamina at certain level
	- author: niceb5y
	- parameters:
		- level: Level of Account
	- returns: Maximum stamina (or -1 if value not exist)
	*/
	public static func staminaAtLevel(level: Int) -> Int {
		if level >= 1 && level <= 150 {
			return stamina[level - 1]
		}
		return -1
	}
}
