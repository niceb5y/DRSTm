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
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if (indexPath as NSIndexPath).section == 1 {
			if (indexPath as NSIndexPath).row == 0 {
				let vc = SFSafariViewController(url: URL(string: "https://twitter.com/deresuteborder")!)
				self.present(vc, animated: true, completion: nil)
			}
      if (indexPath as NSIndexPath).row == 1 {
        let vc = SFSafariViewController(url: URL(string: "https://twitter.com/imas_ml_td_t")!)
        self.present(vc, animated: true, completion: nil)
      }
		} else if (indexPath as NSIndexPath).section == 2 {
			if (indexPath as NSIndexPath).row == 0 {
				let url = URL(string: "mailto:niceb5y+drstm@gmail.com?subject=%EB%8B%B9%EC%8B%A0%EC%9D%B4%20%EC%96%B4%EC%A7%B8%EC%84%9C%20%EA%B0%9C%EB%B0%9C%EC%9E%90%EC%9D%B8%EA%B1%B0%EC%A3%A0%3F")
				UIApplication.shared.openURL(url!)
			}
		}
	}
	
	@IBAction func accountSwitchTouched(_ sender: AnyObject) {
		dk.dualAccountEnabled = accountSwitch.isOn
	}
	
	@IBAction func notificationSwitchTouched(_ sender: AnyObject) {
		dk.notificationEnabled = notificationSwitch.isOn
		if notificationSwitch.isOn {
			let notificationSettings = UIUserNotificationSettings(types: UIUserNotificationType.sound.union(UIUserNotificationType.alert), categories: nil)
			UIApplication.shared.registerUserNotificationSettings(notificationSettings)
			UIApplication.shared.registerForRemoteNotifications()
			DRSTNotification.register()
		} else {
			DRSTNotification.clear()
		}
	}
	@IBAction func iCloudSwitchTouched(_ sender: AnyObject) {
		dk.iCloudEnabled = iCloudSwitch.isOn
	}
}
