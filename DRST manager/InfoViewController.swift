//
//  InfoViewController.swift
//  DRST manager
//
//  Created by 김승호 on 2016. 1. 30..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit
import SafariServices
import DRSTKit

class InfoViewController: UITableViewController {
	let dk = DataKit()
	
	@IBOutlet weak var accountSwitch: UISwitch!
	@IBOutlet weak var notificationSwitch: UISwitch!
	@IBOutlet weak var iCloudSwitch: UISwitch!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		accountSwitch.setOn(dk.dualAccountEnabled, animated: false)
		notificationSwitch.setOn(dk.notificationEnabled, animated: false)
		iCloudSwitch.setOn(dk.iCloudEnabled, animated: false)
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		if indexPath.section == 1 {
			if indexPath.row == 0 {
				let vc = SFSafariViewController(URL: NSURL(string: "https://twitter.com/deresute_border")!)
				self.presentViewController(vc, animated: true, completion: nil)
			}
		} else if indexPath.section == 2 {
			if indexPath.row == 0 {
				let url = NSURL(string: "mailto:niceb5y+drstm@gmail.com?subject=%EB%8B%B9%EC%8B%A0%EC%9D%B4%20%EC%96%B4%EC%A7%B8%EC%84%9C%20%EA%B0%9C%EB%B0%9C%EC%9E%90%EC%9D%B8%EA%B1%B0%EC%A3%A0%3F")
				UIApplication.sharedApplication().openURL(url!)
			}
		}
	}
	
	@IBAction func accountSwitchTouched(sender: AnyObject) {
		dk.dualAccountEnabled = accountSwitch.on
	}
	
	@IBAction func notificationSwitchTouched(sender: AnyObject) {
		dk.notificationEnabled = notificationSwitch.on
		if notificationSwitch.on {
			let notificationSettings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound.union(UIUserNotificationType.Alert), categories: nil)
			UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
			UIApplication.sharedApplication().registerForRemoteNotifications()
			DRSTNotification.register()
		} else {
			DRSTNotification.clear()
		}
	}
	@IBAction func iCloudSwitchTouched(sender: AnyObject) {
		dk.iCloudEnabled = iCloudSwitch.on
	}
}
