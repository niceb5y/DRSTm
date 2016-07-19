//
//  TodayViewController.swift
//  DRST manager
//
//  Created by 김승호 on 2016. 2. 7..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit
import NotificationCenter
import DRSTKit

class TodayViewController: UIViewController, NCWidgetProviding {
	let dk:DataKit = DataKit()
	var timer:NSTimer?
	
	@IBOutlet weak var timeLeftButton: UIButton!
	
	@IBAction func launch(sender: AnyObject) {
		extensionContext?.openURL(NSURL(string: "DRSTm://?method=edit")!, completionHandler: nil)
	}
	
	override func viewDidLoad() {
		timeLeftButton.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
		timeLeftButton.titleLabel?.textAlignment = NSTextAlignment.Center
	}
	
	override func viewWillAppear(animated: Bool) {
		refresh()
		timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
	}
	
	override func viewWillDisappear(animated: Bool) {
		if timer != nil {
			timer?.invalidate()
			timer = nil
		}
	}
	
	override func didReceiveMemoryWarning() {
		if timer != nil {
			timer?.invalidate()
			timer = nil
		}
	}
	
	func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
		return UIEdgeInsetsZero
	}
	
	func refresh() {
		if dk.dualAccountEnabled {
			preferredContentSize = CGSizeMake(0, 98)
			timeLeftButton.setTitle(
				"기기1: 스태미너 \(dk.estimatedCurrentStamina(0)) / \(dk.maxStamina(0))\n"
				+ "\(dk.estimatedTimeLeftString(0)) 남음\n"
				+ "기기 2: 스태미너 \(dk.estimatedCurrentStamina(1)) / \(dk.maxStamina(1))\n"
				+ "\(dk.estimatedTimeLeftString(1)) 남음",
				forState: UIControlState.Normal)
		} else {
			preferredContentSize = CGSizeMake(0, 57)
			timeLeftButton.setTitle("스태미너 \(dk.estimatedCurrentStamina(0)) / \(dk.maxStamina(0))\n\(dk.estimatedTimeLeftString(0)) 남음", forState: UIControlState.Normal)
		}
	}
}
