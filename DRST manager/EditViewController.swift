//
//  EditViewController.swift
//  DRST manager
//
//  Created by 김승호 on 2016. 1. 30..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit
import DRSTKit
import JGProgressHUD

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	var deviceIndex = 0
	var stamina = (max:40, current:0)
	let dk = DataKit.init()
	
	@IBOutlet weak var maxText: UITextField!
	@IBOutlet weak var currentText: UITextField!
	@IBOutlet weak var maxStepper: UIStepper!
	@IBOutlet weak var currentStepper: UIStepper!
	@IBOutlet weak var segmentedButton: UISegmentedControl!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		deviceIndex = 0
		segmentedButton.hidden = !dk.dualAccountEnabled
		load()
	}
	
	func load() {
		setMaximumValue(dk.maxStamina(deviceIndex))
		setCurrentValue(dk.estimatedCurrentStamina(deviceIndex))
	}
	
	func save() {
		view.endEditing(true)
		dk.setMaxStamina(stamina.max, atIndex: deviceIndex)
		dk.setCurrentStamina(stamina.current, atIndex: deviceIndex)
		dk.date = NSDate.init()
		if dk.notificationEnabled {
			DRSTNotification.register()
		} else {
			DRSTNotification.clear()
		}
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		view.endEditing(true)
	}
	
	func setMaximumValue(value:Int) {
		stamina.max = max(min(value, Int(maxStepper.maximumValue)), Int(currentStepper.minimumValue))
		maxText.text = String(stamina.max)
		maxStepper.value = Double(stamina.max)
		currentStepper.maximumValue = Double(stamina.max)
	}
	
	func setCurrentValue(value:Int) {
		stamina.current = max(min(value, Int(currentStepper.maximumValue)), Int(currentStepper.minimumValue))
		currentText.text = String(stamina.current)
		currentStepper.value = Double(stamina.current)
		maxStepper.minimumValue = Double(max(stamina.current, 40))
	}
	
	@IBAction func textMaxTouched(sender: AnyObject) {
		if (maxText.text == "") {
			maxText.text = String(stamina.max)
		} else {
			setMaximumValue(Int(maxText.text!)!)
		}
	}
	
	@IBAction func textCurrentTouched(sender: AnyObject) {
		if (currentText.text == "") {
			currentText.text = String(stamina.current)
		} else {
			setCurrentValue(Int(currentText.text!)!)
		}
	}
	
	@IBAction func maxStepperTouched(sender: AnyObject) {
		setMaximumValue(Int(maxStepper.value))
	}
	
	@IBAction func currentStepperTouched(sender: AnyObject) {
		setCurrentValue(Int(currentStepper.value))
	}
	
	@IBAction func save(sender: AnyObject) {
		save()
		deviceIndex = segmentedButton.selectedSegmentIndex
		load()
		navigationController?.popViewControllerAnimated(true)
	}
	
	@IBAction func segmentedButtonTouched(sender: AnyObject) {
		save()
		deviceIndex = segmentedButton.selectedSegmentIndex
		load()
	}
	
	@IBAction func recognizeScreenshot(sender: AnyObject) {
		let imagePickerController = UIImagePickerController()
		imagePickerController.delegate = self
		imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
		imagePickerController.allowsEditing = false
		presentViewController(imagePickerController, animated: true, completion: nil)
	}
	
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		dismissViewControllerAnimated(true, completion: nil)
		let image = info[UIImagePickerControllerOriginalImage] as! UIImage
		let ocr = DRSTOCR()
		let indicator = JGProgressHUD(style: JGProgressHUDStyle.Dark)
		indicator.showInView(self.view)
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
			do {
				let level = try? ocr.getLevelOf(image)
				if level != nil {
					dispatch_async(dispatch_get_main_queue(), { () -> Void in
						self.setMaximumValue(DRSTStamina.staminaAtLevel(level!))
					})
				} else {
					dispatch_async(dispatch_get_main_queue(), { () -> Void in
						let HUD = JGProgressHUD(style: JGProgressHUDStyle.Dark)
						HUD.textLabel.text = "레벨 인식 에러"
						HUD.indicatorView = JGProgressHUDErrorIndicatorView()
						HUD.showInView(self.view)
						HUD.dismissAfterDelay(1.5)
					})
				}
				let stamina = try? ocr.getStaminaOf(image)
				if stamina != nil {
					dispatch_async(dispatch_get_main_queue(), { () -> Void in
						self.setCurrentValue(stamina!)
					})
				} else {
					dispatch_async(dispatch_get_main_queue(), { () -> Void in
						let HUD = JGProgressHUD(style: JGProgressHUDStyle.Dark)
						HUD.textLabel.text = "스태미너 인식 에러"
						HUD.indicatorView = JGProgressHUDErrorIndicatorView()
						HUD.showInView(self.view)
						HUD.dismissAfterDelay(1.5)
					})
				}
				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					indicator.dismiss()
				})
			}
		}
	}
}
