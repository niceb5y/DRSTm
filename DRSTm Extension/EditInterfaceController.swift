//
//  EditInterfaceController.swift
//  DRST manager
//
//  Created by 김승호 on 2016. 7. 24..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import WatchKit

class EditInterfaceController: WKInterfaceController {
	
	@IBOutlet var staminaPicker: WKInterfacePicker!
	var itemList = ["0"]
	var selected = "0"
	
	override init() {
		super.init()
	}
	
	override func awake(withContext context: Any?) {
		super.awake(withContext: context)
		updateState()
	}
	
	override func willActivate() {
		super.willActivate()
	}
	
	override func didDeactivate() {
		super.didDeactivate()
	}

	func updateState() {
		let delegate = WKExtension.shared().delegate as! ExtensionDelegate
		delegate.requestState({ (current, max, timeLeft) in
			self.itemList = []
			for i in (0...max).reversed() {
				self.itemList.append("\(i)")
			}
			let pickerItem = self.itemList.map({(item) -> WKPickerItem in
				let picker = WKPickerItem()
				picker.caption = "스태미너"
				picker.title = item
				return picker
			})
			self.staminaPicker.setItems(pickerItem)
		})
	}
	
	@IBAction func pickerChanged(_ value: Int) {
		selected = itemList[value]
		debugPrint(itemList[value])
	}
	
	@IBAction func setState() {
		let delegate = WKExtension.shared().delegate as! ExtensionDelegate
		delegate.setState(selected) { (success) in
			if success {
				self.pop()
			}
		}
	}
}
