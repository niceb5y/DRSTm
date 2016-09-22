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
			session = WCSession.default()
			session!.delegate = self
			session!.activate()
		}
	}
  
  @available(iOS 9.3, *)
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    
  }
  
  /** Called when all delegate callbacks for the previously selected watch has occurred. The session can be re-activated for the now selected watch using activateSession. */
  @available(iOS 9.3, *)
  public func sessionDidDeactivate(_ session: WCSession) {
    
  }
  
  /** Called when the session can no longer be used to modify or add any new transfers and, all interactive messages will be cancelled, but delegate callbacks for background transfers can still occur. This will happen when the selected watch is being changed. */
  @available(iOS 9.3, *)
  public func sessionDidBecomeInactive(_ session: WCSession) {
    
  }
  
	func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
		let req = message["req"] as! String
		if req == "?" {
			let queue = DispatchQueue.global()
			queue.async(execute: {() -> () in
				let result:[String:AnyObject] = [
				"current": self.dk.estimatedCurrentStamina(0) as AnyObject,
				"max": self.dk.maxStamina(0) as AnyObject,
				"timeLeft": self.dk.estimatedTimeLeftString(0) as AnyObject
				]
				replyHandler(result)
			})
		}
		
		if req == "set" {
			let value = Int(message["value"] as! String)
			self.dk.setCurrentStamina(value!, atIndex: 0)
			self.dk.date = Date()
			let result:[String:AnyObject] = [
				"success":true as AnyObject
			]
			replyHandler(result)
		}
	}
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		return true
	}
	
	func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
		let query = url.query
		if query == "method=edit" {
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let editViewController = storyboard.instantiateViewController(withIdentifier: "EditViewController")
			let nav = self.window?.rootViewController?.childViewControllers[0] as! UINavigationController
			nav.pushViewController(editViewController, animated: true)
		}
		return true
	}
	
	func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
		if shortcutItem.type == "com.niceb5y.drstm.edit" {
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let editViewController = storyboard.instantiateViewController(withIdentifier: "EditViewController")
			let nav = self.window?.rootViewController?.childViewControllers[0] as! UINavigationController
			nav.pushViewController(editViewController, animated: true)
		}
	}
}
