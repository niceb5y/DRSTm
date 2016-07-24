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
	var timer:NSTimer?
	
	override init() {
		super.init()
		self.updateState()
	}
	
	override func awakeWithContext(context: AnyObject?) {
		super.awakeWithContext(context)
  }

	override func willActivate() {
		super.willActivate()
		timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(updateState), userInfo: nil, repeats: true)
	}

	override func didDeactivate() {
		super.didDeactivate()
		timer = nil
	}
	
	func updateState() {
		let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
		dispatch_async(queue, {() -> () in
			let delegate = WKExtension.sharedExtension().delegate as! ExtensionDelegate
			delegate.requestState({ (current, max, timeLeft) in
				let main_queue = dispatch_get_main_queue()
				dispatch_async(main_queue, {() -> () in
					self.lblCurrent.setText("\(current)")
					self.lblTimeLeft.setText("\(timeLeft) 남음")
				})
			})
		})
	}
}
