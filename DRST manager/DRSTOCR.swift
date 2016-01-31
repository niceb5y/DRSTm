//
//  OCRKit.swift
//  DRSTm
//
//  Created by 김승호 on 2016. 1. 26..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit
import DRSTKit
import TesseractOCR

class DRSTOCR: NSObject, G8TesseractDelegate {
	let tesseract = G8Tesseract(language: "eng")
	
	enum RecognitionError:ErrorType {
		case Level, Stamina, EXP
	}
	
	override init() {
		super.init()
		tesseract.delegate = self
	}
	
	func getLevelOf(image:UIImage) throws -> Int {
		tesseract.charWhitelist = "01234567890"
		tesseract.image = image.convertToGrayScale()
		let devicetype = tesseract.image.size.width / tesseract.image.size.height < 1.5 ? ScreenPosition.DeviceType.pad : ScreenPosition.DeviceType.phone_pod
		tesseract.rect = ScreenPosition.levelArea(Double(image.size.width), type: devicetype)
		tesseract.recognize()
		let text = tesseract.recognizedText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
		if let result = Int(text) {
			return result
		} else {
			throw RecognitionError.Level
		}
	}
	
	func getStaminaOf(image:UIImage) throws -> Int {
		tesseract.charWhitelist = "01234567890/"
		tesseract.image = image.convertToGrayScale()
		let devicetype = tesseract.image.size.width / tesseract.image.size.height < 1.5 ? ScreenPosition.DeviceType.pad : ScreenPosition.DeviceType.phone_pod
		tesseract.rect = ScreenPosition.staminaArea(Double(image.size.width), type: devicetype)
		tesseract.recognize()
		let text = tesseract.recognizedText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
		if text.containsString("/") {
			let result = text.componentsSeparatedByString("/")
			let cur = Int(result[0])
			if cur != nil {
				return cur!
			}
		}
		throw RecognitionError.Stamina
	}

	func getEXPOf(image:UIImage) throws -> Int {
		tesseract.charWhitelist = "01234567890/"
		tesseract.image = image.convertToGrayScale()
		let devicetype = tesseract.image.size.width / tesseract.image.size.height < 1.5 ? ScreenPosition.DeviceType.pad : ScreenPosition.DeviceType.phone_pod
		tesseract.rect = ScreenPosition.expArea(Double(image.size.width), type: devicetype)
		tesseract.recognize()
		let text = tesseract.recognizedText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
		if text.containsString("/") {
			let result = text.componentsSeparatedByString("/")
			let cur = Int(result[0])
			if cur != nil {
				return cur!
			}
		}
		throw RecognitionError.EXP
	}
}

extension UIImage {
	func convertToGrayScale() -> UIImage {
		let imageRect = CGRectMake(0, 0, self.size.width, self.size.height)
		let colorSpace = CGColorSpaceCreateDeviceGray()
		let context = CGBitmapContextCreate(nil, Int(self.size.width), Int(self.size.height), 8, 0, colorSpace, 0)
		CGContextDrawImage(context, imageRect, self.CGImage)
		let imageRef = CGBitmapContextCreateImage(context)
		return UIImage.init(CGImage: imageRef!)
	}
}