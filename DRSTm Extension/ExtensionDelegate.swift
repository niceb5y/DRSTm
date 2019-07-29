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
      session = WCSession.default
			session!.delegate = self
			session!.activate()
		}
	}
  
  /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
  @available(watchOS 2.2, *)
  public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    
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
	
	func requestState(_ resultHandler:@escaping (_ current:Int, _ max:Int, _ timeLeft:String)->()) {
		guard let session = session else { return }
		session.sendMessage(["req" : "?"], replyHandler: { (res) in
			let current = res["current"] as! Int
			let max = res["max"] as! Int
			let timeLeft = res["timeLeft"] as! String
				resultHandler(current, max, timeLeft)
		}, errorHandler:{ (error) in
			debugPrint(error)
		})
	}
	
	func setState(_ value:String, resultHandler:@escaping (_ success:Bool) -> ()) {
		guard let session = session else { return }
		session.sendMessage(["req" : "set", "value": value], replyHandler: { (res) -> () in
			let success = res["success"] as! Bool
			resultHandler(success)
		}, errorHandler:{ (error) in
			debugPrint(error)
		})
	}

}
