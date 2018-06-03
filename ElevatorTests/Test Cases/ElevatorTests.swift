//
//  ElevatorTests.swift
//  ElevatorTests
//
//  Created by David Witt on 2018-04-01.
//  Copyright © 2018 David Witt. All rights reserved.
//

import XCTest
@testable import Elevator

class ElevatorTests: XCTestCase {
  
  var elevator: Elevator!
  
  override func setUp() {
    super.setUp()
    
    elevator = Elevator(ratedSpeed: Measurement(value: 0.5, unit: .metersPerSecond), capacity: 1134, governorSpeedReducingSwitch: false, staticControl: false)
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testInit_Speed() {

    XCTAssertEqual(elevator.ratedSpeed.value, 0.5)
    XCTAssertEqual(elevator.ratedSpeed.unitSystem, .metric)
    
  }
  func testInit_Capacity() {
    
    XCTAssertEqual(elevator.capacity, 1134)
  }
  
  func testInit_GovernorSpeedReducingSwitch() {
    
    XCTAssertFalse(elevator.governorSpeedReducingSwitch)
  }

  func testInit_staticControl() {
    XCTAssertFalse(elevator.staticControl)
  }
  
  func testInit_GovernorTrippingSpeed() {
    
    XCTAssertEqual(elevator.governorTrippingSpeed.value, 0.0)
    XCTAssertEqual(elevator.governorTrippingSpeed.unit, elevator.ratedSpeed.unit)
  }
  
}
