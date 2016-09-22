//
//  GlanceController.swift
//  DRSTm Extension
//
//  Created by 김승호 on 2016. 7. 20..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {

	@IBOutlet var lblCurrent: WKInterfaceLabel!
	@IBOutlet var lblTimeLeft: WKInterfaceLabel!
	var timer:Timer?
	
	override init() {
		super.init()
		self.updateState()
	}
	
	override func awake(withContext context: Any?) {
		super.awake(withContext: context)
  }

	override func willActivate() {
		super.willActivate()
		timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateState), userInfo: nil, repeats: true)
	}

	override func didDeactivate() {
		super.didDeactivate()
		timer = nil
	}
	
	func updateState() {
		let queue = DispatchQueue.global()
		queue.async(execute: {() -> () in
			let delegate = WKExtension.shared().delegate as! ExtensionDelegate
			delegate.requestState({ (current, max, timeLeft) in
				let main_queue = DispatchQueue.main
				main_queue.async(execute: {() -> () in
					self.lblCurrent.setText("\(current)")
					self.lblTimeLeft.setText("\(timeLeft) 남음")
				})
			})
		})
	}
}
