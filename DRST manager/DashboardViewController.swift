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
	var timer:Timer?
	let dk = DataKit()
	var deviceIndex = 0
	
	@IBOutlet weak var timeLeftLabel: UILabel!
	@IBOutlet weak var timeEstimateLabel: UILabel!
	@IBOutlet weak var staminaLabel: UILabel!
	@IBOutlet weak var segmentedButton: UISegmentedControl!
	@IBOutlet weak var circularProgress: CircularProgress!
  
  override func viewDidLoad() {
		segmentedButton.isHidden = !dk.dualAccountEnabled
		deviceIndex = 0
		refresh()
		timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		segmentedButton.isHidden = !dk.dualAccountEnabled
		if !dk.dualAccountEnabled {
			deviceIndex = 0
		}
		refresh()
	}
	
  @objc func refresh() {
		let max = dk.maxStamina(deviceIndex)
		let cur = dk.estimatedCurrentStamina(deviceIndex)
		staminaLabel.text = "\(cur) / \(max)"
		timeEstimateLabel.text = "\(dk.estimatedCompleteTimeString(deviceIndex)) MAX"
		timeLeftLabel.text = dk.estimatedTimeLeftString(deviceIndex)
    circularProgress.update(progress: CGFloat(cur) / CGFloat(max))
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		if timer != nil {
			timer?.invalidate()
			timer = nil
		}
	}
	
	@IBAction func segmentedButtonTouched(_ sender: AnyObject) {
		deviceIndex = segmentedButton.selectedSegmentIndex
	}
	
	@IBAction func launchApp(_ sender: AnyObject) {
		DRSTNotification.clear()
		UIApplication.shared.openURL(URL(string: "starlightstage://")!)
	}
}
