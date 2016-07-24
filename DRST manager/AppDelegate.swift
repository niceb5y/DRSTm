//
//  AppDelegate.swift
//  DRST manager
//
//  Created by 김승호 on 2016. 7. 24..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit
import DRSTKit
import WatchConnectivity

@UIApplicationMain

class AppDelegate:UIResponder, UIApplicationDelegate, WCSessionDelegate {
	var window: UIWindow?
	var session: WCSession?
	let dk = DataKit()
	
	override init() {
		super.init()
		if WCSession.isSupported() {
			session = WCSession.defaultSession()
			session!.delegate = self
			session!.activateSession()
		}
	}
	
	func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
		let req = message["req"] as! String
		if req == "?" {
			let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
			dispatch_async(queue, {() -> () in
				let result:[String:AnyObject] = [
				"current": self.dk.estimatedCurrentStamina(0),
				"max": self.dk.maxStamina(0),
				"timeLeft": self.dk.estimatedTimeLeftString(0)
				]
				replyHandler(result)
			})
		}
		
		if req == "set" {
			let value = Int(message["value"] as! String)
			self.dk.setCurrentStamina(value!, atIndex: 0)
			self.dk.date = NSDate()
			let result:[String:AnyObject] = [
				"success":true
			]
			replyHandler(result)
		}
	}
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
		return true
	}
	
	func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
		let query = url.query
		if query == "method=edit" {
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let editViewController = storyboard.instantiateViewControllerWithIdentifier("EditViewController")
			let nav = self.window?.rootViewController?.childViewControllers[0] as! UINavigationController
			nav.pushViewController(editViewController, animated: true)
		}
		return true
	}
	
	func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
		if shortcutItem.type == "com.niceb5y.drstm.edit" {
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let editViewController = storyboard.instantiateViewControllerWithIdentifier("EditViewController")
			let nav = self.window?.rootViewController?.childViewControllers[0] as! UINavigationController
			nav.pushViewController(editViewController, animated: true)
		}
	}
}
