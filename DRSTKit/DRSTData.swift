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
open class DRSTData: NSObject {
	
	/**
	User group of deresute account.
	* Group A ~ H
	*/
	public enum UserGroup: Int {
		case a, b, c, d, e, f, g, h
	}
	
	/**
	Level of deresute songs.
	* Debut
	* Regular
	* Pro
	* Master
	*/
	public enum SongLevel: Int {
		case debut, regular, pro, master
	}
	
	/**
	Array of user device data.
	*/
	open var deviceData: Array<Device> {
		get {
			var _deviceData = Helper.loadObject("DeviceData", fromCloud: notificationEnabled) as? Array<Device>
			if _deviceData == nil {
				_deviceData = Array<Device>()
				_deviceData?.append(Device())
			}
			return _deviceData!
		}
		
		set(deviceData) {
			_ = Helper.saveObject(deviceData as AnyObject, forKey: "DeviceData", toCloud: notificationEnabled)
		}
	}
	
	/**
	If notification is enabled by user.
	*/
	open var notificationEnabled: Bool {
		get {
			var _notificationEnabled: Bool? = Helper.loadBool("NotificationEnabled")
			if _notificationEnabled == nil {
				_notificationEnabled = false
			}
			return _notificationEnabled!
		}
		
		set(notificationEnabled) {
			_ = Helper.saveBool(notificationEnabled, forKey: "NotificationEnabled")
		}
	}
}
