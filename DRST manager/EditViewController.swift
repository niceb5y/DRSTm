//
//  EditViewController.swift
//  DRST manager
//
//  Created by 김승호 on 2016. 1. 30..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit
import DRSTKit

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	var deviceIndex = 0
	var stamina = (max:40, current:0)
	let dk = DataKit.init()
	
	@IBOutlet weak var maxText: UITextField!
	@IBOutlet weak var currentText: UITextField!
	@IBOutlet weak var maxStepper: UIStepper!
	@IBOutlet weak var currentStepper: UIStepper!
	@IBOutlet weak var segmentedButton: UISegmentedControl!
	@IBOutlet weak var indicator: UIActivityIndicatorView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		indicator.stopAnimating()
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
		setMaximumValue(Int(maxText.text!)!)
	}
	
	@IBAction func textCurrentTouched(sender: AnyObject) {
		setCurrentValue(Int(currentText.text!)!)
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
	
	func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
		dismissViewControllerAnimated(true, completion: nil)
		let ocr = DRSTOCR()
		do {
			indicator.startAnimating()
			let level = try? ocr.getLevelOf(image)
			if level != nil {
				setMaximumValue(Stamina.staminaAtLevel(level!))
			} else {
				let alertController = UIAlertController(title: "인식 에러", message: "레벨을 인식할 수 없습니다.", preferredStyle: UIAlertControllerStyle.Alert)
				alertController.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.Default,handler: nil))
				self.presentViewController(alertController, animated: true, completion: nil)
			}
			let stamina = try? ocr.getStaminaOf(image)
			if stamina != nil {
				setCurrentValue(stamina!)
			} else {
				let alertController = UIAlertController(title: "인식 에러", message: "스태미너를 인식할 수 없습니다.", preferredStyle: UIAlertControllerStyle.Alert)
				alertController.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.Default,handler: nil))
				self.presentViewController(alertController, animated: true, completion: nil)
			}
			indicator.stopAnimating()
		}
	}
}
