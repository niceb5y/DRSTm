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

/**
OCR class for DRST manager
- author: niceb5y
*/
class DRSTOCR: NSObject, G8TesseractDelegate {
	let tesseract = G8Tesseract(language: "eng")
	
	enum RecognitionError:ErrorType {
		case Level, Stamina, EXP
	}
	
	override init() {
		super.init()
		tesseract.delegate = self
	}
	
	/**
	Recognize Level from Screenshot.
	- author: niceb5y
	- parameters:
		- image: Screenshot to recognize.
	- returns: Level
	- throws: RecognitionError.Level
	*/
	func getLevelOf(image:UIImage) throws -> Int {
		tesseract.charWhitelist = "01234567890"
		tesseract.image = Helper.Image.convertToGrayScale(image)
		let devicetype = tesseract.image.size.width / tesseract.image.size.height < 1.5 ? DRSTScreenPosition.DeviceType.pad : DRSTScreenPosition.DeviceType.phone_pod
		tesseract.rect = DRSTScreenPosition.levelArea(Double(image.size.width), type: devicetype)
		tesseract.recognize()
		let text = tesseract.recognizedText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
		if let result = Int(text) {
			return result
		} else {
			throw RecognitionError.Level
		}
	}
	
	/**
	Recognize Stamina from Screenshot.
	- author: niceb5y
	- parameters:
		- image: Screenshot to recognize.
	- returns: Stamina
	- throws: RecognitionError.Stamina
	*/
	func getStaminaOf(image:UIImage) throws -> Int {
		tesseract.charWhitelist = "01234567890/"
		tesseract.image = Helper.Image.convertToGrayScale(image)
		let devicetype = tesseract.image.size.width / tesseract.image.size.height < 1.5 ? DRSTScreenPosition.DeviceType.pad : DRSTScreenPosition.DeviceType.phone_pod
		tesseract.rect = DRSTScreenPosition.staminaArea(Double(image.size.width), type: devicetype)
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

	/**
	Recognize EXP from Screenshot.
	- author: niceb5y
	- parameters:
		- image: Screenshot to recognize.
	- returns: EXP
	- warning:
	It can't recognize well.
	- throws: RecognitionError.EXP
	*/
	func getEXPOf(image:UIImage) throws -> Int {
		tesseract.charWhitelist = "01234567890/"
		tesseract.image = Helper.Image.convertToGrayScale(image)
		let devicetype = tesseract.image.size.width / tesseract.image.size.height < 1.5 ? DRSTScreenPosition.DeviceType.pad : DRSTScreenPosition.DeviceType.phone_pod
		tesseract.rect = DRSTScreenPosition.expArea(Double(image.size.width), type: devicetype)
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
	
	/**
	Helper class for DRSTOCR
	- author: niceb5y
	*/
	class Helper {
		/**
		Image helper class
		- author: niceb5y
		*/
		class Image {
			/**
			Convert Image into grayscaled image.
			- author: niceb5y
			- parameters:
				- image: Image to convert.
			- returns: Grayscaled image
			*/
			static func convertToGrayScale(image:UIImage) -> UIImage {
				let beginImage = CIImage(image: image)!
				
				let blackAndWhite = CIFilter(name: "CIColorControls", withInputParameters: [
					kCIInputImageKey: beginImage,
					kCIInputBrightnessKey: 0.0,
					kCIInputContrastKey: 1.1,
					kCIInputSaturationKey: 0.0
					])!.outputImage!
				
				let output = CIFilter(name: "CIExposureAdjust", withInputParameters: [
					kCIInputImageKey: blackAndWhite,
					kCIInputEVKey: 0.7
					])!.outputImage!
				
				let context = CIContext(options: nil)
				
				return UIImage(CGImage: context.createCGImage(output, fromRect: output.extent),
					scale: 0, orientation: image.imageOrientation)
			}
		}
	}
}
