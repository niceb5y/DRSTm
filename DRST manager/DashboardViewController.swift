//
//  DashboardViewController.swift
//  DRST manager
//
//  Created by 김승호 on 2016. 1. 30..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit
import DRSTKit

class DashboardViewController: UIViewController {
	var timer:NSTimer?
	let dk = DataKit()
	var deviceIndex = 0
	
	@IBOutlet weak var timeLeftLabel: UILabel!
	@IBOutlet weak var timeEstimateLabel: UILabel!
	@IBOutlet weak var staminaLabel: UILabel!
	@IBOutlet weak var staminaProgress: UIProgressView!
	@IBOutlet weak var segmentedButton: UISegmentedControl!
	
	override func viewDidLoad() {
		segmentedButton.hidden = !dk.dualAccountEnabled
		deviceIndex = 0
		refresh()
		timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		segmentedButton.hidden = !dk.dualAccountEnabled
		if !dk.dualAccountEnabled {
			deviceIndex = 0
		}
		refresh()
	}
	
	func refresh() {
		let max = dk.maxStamina(deviceIndex)
		let cur = dk.estimatedCurrentStamina(deviceIndex)
		staminaLabel.text = "\(cur) / \(max)"
		timeEstimateLabel.text = "예상 스태미너 MAX 시간: \(dk.estimatedCompleteTimeString(deviceIndex))"
		timeLeftLabel.text = dk.estimatedTimeLeftString(deviceIndex)
		staminaProgress.progress = Float(cur) / Float(max)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		if timer != nil {
			timer?.invalidate()
			timer = nil
		}
	}
	
	@IBAction func segmentedButtonTouched(sender: AnyObject) {
		deviceIndex = segmentedButton.selectedSegmentIndex
	}
	
	@IBAction func launchApp(sender: AnyObject) {
		DRSTNotification.clear()
		UIApplication.sharedApplication().openURL(NSURL(string: "starlightstage://")!)
	}
}
