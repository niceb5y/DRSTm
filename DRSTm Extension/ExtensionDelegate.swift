//
//  ExtensionDelegate.swift
//  DRSTm Extension
//
//  Created by 김승호 on 2016. 7. 20..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import WatchKit
import WatchConnectivity

class ExtensionDelegate: NSObject, WKExtensionDelegate, WCSessionDelegate {
	
	var session:WCSession? = nil
	
	override init() {
		super.init()
		if WCSession.isSupported() {
			session = WCSession.defaultSession()
			session!.delegate = self
			session!.activateSession()
		}
	}

	func applicationDidFinishLaunching() {
		// Perform any final initialization of your application.
	}

	func applicationDidBecomeActive() {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillResignActive() {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, etc.
	}
	
	func requestState(resultHandler:(current:Int, max:Int, timeLeft:String)->()) {
		guard let session = session else { return }
		session.sendMessage(["req" : "?"], replyHandler: { (res) in
			let current = res["current"] as! Int
			let max = res["max"] as! Int
			let timeLeft = res["timeLeft"] as! String
				resultHandler(current: current, max: max, timeLeft: timeLeft)
		}, errorHandler:{ (error) in
			debugPrint(error)
		})
	}
	
	func setState(value:String, resultHandler:(success:Bool) -> ()) {
		guard let session = session else { return }
		session.sendMessage(["req" : "set", "value": value], replyHandler: { (res) -> () in
			let success = res["success"] as! Bool
			resultHandler(success: success)
		}, errorHandler:{ (error) in
			debugPrint(error)
		})
	}

}
