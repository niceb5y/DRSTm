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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		deviceIndex = 0
		segmentedButton.isHidden = !dk.dualAccountEnabled
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
		dk.date = Date.init()
		if dk.notificationEnabled {
			DRSTNotification.register()
		} else {
			DRSTNotification.clear()
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}
	
	func setMaximumValue(_ value:Int) {
		stamina.max = max(min(value, Int(maxStepper.maximumValue)), Int(currentStepper.minimumValue))
		maxText.text = String(stamina.max)
		maxStepper.value = Double(stamina.max)
		currentStepper.maximumValue = Double(stamina.max)
	}
	
	func setCurrentValue(_ value:Int) {
		stamina.current = max(min(value, Int(currentStepper.maximumValue)), Int(currentStepper.minimumValue))
		currentText.text = String(stamina.current)
		currentStepper.value = Double(stamina.current)
		maxStepper.minimumValue = Double(max(stamina.current, 40))
	}
	
	@IBAction func textMaxTouched(_ sender: AnyObject) {
		if (maxText.text == "") {
			maxText.text = String(stamina.max)
		} else {
			setMaximumValue(Int(maxText.text!)!)
		}
	}
	
	@IBAction func textCurrentTouched(_ sender: AnyObject) {
		if (currentText.text == "") {
			currentText.text = String(stamina.current)
		} else {
			setCurrentValue(Int(currentText.text!)!)
		}
	}
	
	@IBAction func maxStepperTouched(_ sender: AnyObject) {
		setMaximumValue(Int(maxStepper.value))
	}
	
	@IBAction func currentStepperTouched(_ sender: AnyObject) {
		setCurrentValue(Int(currentStepper.value))
	}
	
	@IBAction func save(_ sender: AnyObject) {
		save()
		deviceIndex = segmentedButton.selectedSegmentIndex
		load()
		_ = navigationController?.popViewController(animated: true)
	}
	
	@IBAction func segmentedButtonTouched(_ sender: AnyObject) {
		save()
		deviceIndex = segmentedButton.selectedSegmentIndex
		load()
	}
}
