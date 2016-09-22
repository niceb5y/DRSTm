//
//  DRSTmTests.swift
//  DRSTmTests
//
//  Created by 김승호 on 2016. 2. 9..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import XCTest
import DRSTKit

class DRSTmTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
	
	/**
	TestDRST.Data.Device Class
	*/
	func testDRSTDataDevice() {
		let device = DRSTData.Device()
		XCTAssertEqual(device.level, 1)
		XCTAssertEqual(device.stamina, 0)
		XCTAssertEqual(device.exp, 0)
		XCTAssertEqual(device.group, DRSTData.UserGroup.a)
		XCTAssertEqual(device.preferLevel, DRSTData.SongLevel.debut)
		XCTAssertEqual(device.preferEventLevel, DRSTData.SongLevel.debut)
	}
	
	/**
	Test DRSTData.Helper class
	*/
	func testDRSTDataHelper() {
		self.measure { () -> Void in
			//Test load/save/delete bool value
			let boolKey = "UnitTestBool"
			XCTAssertEqual(DRSTData.Helper.saveBool(true, forKey: boolKey), true)
			XCTAssertEqual(DRSTData.Helper.loadBool(boolKey), true)
			XCTAssertEqual(DRSTData.Helper.removeObject(boolKey), true)

			//Test load/save/delete object
			let device = DRSTData.Device()
			let objectKey = "UnitTestObject"
			XCTAssertEqual(DRSTData.Helper.saveObject(device, forKey: objectKey), true)
			XCTAssertNotNil(DRSTData.Helper.loadObject(objectKey))
			XCTAssertEqual(DRSTData.Helper.removeObject(objectKey), true)
		}
	}
	
	/**
	Test DRSTData.Helper class with iCloud
	*/
	func testDRSTDataHelperCloud() {
		self.measure { () -> Void in
			//Test load/save/delete bool value
			let boolKey = "UnitTestBool"
			XCTAssertEqual(DRSTData.Helper.saveBool(true, forKey: boolKey, toCloud: true), true)
			XCTAssertEqual(DRSTData.Helper.loadBool(boolKey, fromCloud: true), true)
			XCTAssertEqual(DRSTData.Helper.removeObject(boolKey, fromCloud: true), true)
			
			//Test load/save/delete object
			let device = DRSTData.Device()
			let objectKey = "UnitTestObject"
			XCTAssertEqual(DRSTData.Helper.saveObject(device, forKey: objectKey, toCloud: true), true)
			XCTAssertNotNil(DRSTData.Helper.loadObject(objectKey, fromCloud: true))
			XCTAssertEqual(DRSTData.Helper.removeObject(objectKey, fromCloud: true), true)
		}
	}
	
	/**
	Test DRSTEXP class
	*/
	func testDRSTEXP() {
		for level in 1...150 {
			XCTAssertNotEqual(DRSTEXP.expAtLevel(level), -1)
		}
	}
	
	/**
	Test DRSTStamina class
	*/
	func testDRSTStamina() {
		for level in 1...150 {
			XCTAssertNotEqual(DRSTStamina.staminaAtLevel(level), -1)
		}
	}
	
	/**
	Test DRSTKit class
	*/
	func testDRSTKit() {
		XCTAssertEqual(DRSTKit.Kisaragi_Chihaya, 72)
	}
}
