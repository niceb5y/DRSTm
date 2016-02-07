//
//  ScreenPosition.swift
//  DRSTKit
//
//  Created by 김승호 on 2016. 1. 18..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit

/**
Deresute UI screen position for OCR
- author: niceb5y
*/
public class ScreenPosition: NSObject {
	
	/**
	Type of device
	* phone_pod: 16: 9 display
	* pad: 4: 3 display
	*/
	public enum DeviceType: Int {
		case phone_pod, pad
	}
	
	/**
	Level area
	- author: niceb5y
	- parameters: 
		- width: Width of screen
		- type: Type of device
	- returns: CGRect of level area
	*/
	public static func levelArea(width: Double, type: DeviceType) -> CGRect {
		if type == DeviceType.phone_pod {
			return CGRectMake(CGFloat(0.13 * width), CGFloat(0.013 * width), CGFloat(0.043 * width), CGFloat(0.016 * width))
		} else {
			return CGRectMake(CGFloat(0.06 * width), CGFloat(0.016 * width), CGFloat(0.052 * width), CGFloat(0.018 * width))
		}
	}
	
	/**
	EXP area
	- author: niceb5y
	- parameters: 
		- width: Width of screen
		- type: Type of device
	- returns: CGRect of exp area
	*/
	public static func expArea(width: Double, type: DeviceType) -> CGRect {
		if type == DeviceType.phone_pod {
			return CGRectMake(CGFloat(0.13 * width), CGFloat(0.035 * width), CGFloat(0.08 * width), CGFloat(0.014 * width))
		} else {
			return CGRectMake(CGFloat(0.06 * width), CGFloat(0.04 * width), CGFloat(0.096 * width), CGFloat(0.017 * width))
		}
	}
	
	/**
	Stamina area
	- author: niceb5y
	- parameters:
		- width: Width of screen
		- type: Type of device
	- returns: CGRect of stamina area
	*/
	public static func staminaArea(width: Double, type: DeviceType) -> CGRect {
		if type == DeviceType.phone_pod {
			return CGRectMake(CGFloat(0.28 * width), CGFloat(0.035 * width), CGFloat(0.063 * width), CGFloat(0.014 * width))
		} else {
			return CGRectMake(CGFloat(0.24 * width), CGFloat(0.04 * width), CGFloat(0.074 * width), CGFloat(0.017 * width))
		}
	}
	
	/**
	Time left area
	- author: niceb5y
	- parameters: 
		- width: Width of screen
		- type: Type of device
	- returns: CGRect of time left area
	*/
	public static func timeArea(width: Double, type: DeviceType) -> CGRect {
		if type == DeviceType.phone_pod {
			return CGRectMake(CGFloat(0.304 * width), CGFloat(0.013 * width), CGFloat(0.04 * width), CGFloat(0.016 * width))
		} else {
			return CGRectMake(CGFloat(0.268 * width), CGFloat(0.016 * width), CGFloat(0.046 * width), CGFloat(0.018 * width))
		}
	}
}
