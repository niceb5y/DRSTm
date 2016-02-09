//
//  DetailViewController.swift
//  DRSTm
//
//  Created by 김승호 on 2016. 1. 15..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit
import TesseractOCR
import DRSTKit
import Photos

class DetailViewController: UIViewController, G8TesseractDelegate {

	@IBOutlet weak var detailDescriptionLabel: UILabel!
	
	let ocr = OCRKit()

	var detailItem: AnyObject? {
		didSet {
		    // Update the view.
		    self.configureView()
		}
	}

	func configureView() {
		// Update the user interface for the detail item.
		if let detail = self.detailItem {
		    if let label = self.detailDescriptionLabel {
		        label.text = detail.description
		    }
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.configureView()
		
//		for index in 1...6 {
//			let image = UIImage(named: "image_sample" + String(index) + ".jpg") as UIImage!
//			let stamina = ocr.getStaminaOf(image)
//			let level = ocr.getLevelOf(image)
//			let exp = ocr.getEXPOf(image)
//			
//			NSLog("\nCase \(index)\n"
//				+ "stamina: \(stamina)\n"
//				+ "level: \(level)\n"
//				+ "exp: \(exp)\n"
//				+ "\n"
//			);
//		}

		let fetchOptions = PHFetchOptions()
		fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
		let fetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: fetchOptions)
		
		if let lastAsset: PHAsset = fetchResult.lastObject as? PHAsset {
			
			let manager = PHImageManager.defaultManager()
			let imageRequestOptions = PHImageRequestOptions()
			
			manager.requestImageDataForAsset(lastAsset, options: imageRequestOptions) {
				(let imageData: NSData?, let dataUTI: String?,
				let orientation: UIImageOrientation,
				let info: [NSObject : AnyObject]?) -> Void in
				
				if let imageDataUnwrapped = imageData, lastImageRetrieved = UIImage(data: imageDataUnwrapped) {
					let image = lastImageRetrieved
					
				}
			}
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	
	func shouldCancelImageRecognitionForTesseract(tesseract: G8Tesseract!) -> Bool {
		return false; // return true if you need to interrupt tesseract before it finishes
	}

}

