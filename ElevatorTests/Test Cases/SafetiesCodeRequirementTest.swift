//
//  SafetiesCodeRequirementTest.swift
//  ElevatorTests
//
//  Created by David Witt on 2018-04-08.
//  Copyright © 2018 David Witt. All rights reserved.
//

import XCTest
@testable import Elevator



class SafetiesCodeRequirementTest: XCTestCase {
  
  
  
    override func setUp() {

        super.setUp()
      
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
//  func testInit() {
//    let safeties = SafetiesCodeRequirement()
//    XCTAssertNotNil(safeties)
//
//  }
  
  func testStoppingDistance_atLowSpeed() {
    
    var safeties: SafetiesCodeRequirement
    
    do {
      try safeties = SafetiesCodeRequirement()
    }
    catch {
      fatalError()
    }
    
    safeties.governorTrippingSpeed = Measurement(value:0.5, unitSystem: .metric)
    safeties.maximumGovernorTrippingSpeed = Measurement(value:1.0, unitSystem: .metric)
    safeties.useGovernorTrippingSpeedForStoppingDistance = true
    var minimumStoppingDistance = safeties.minimumStoppingDistance
    var maximumStoppingDistance = safeties.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance.value,25)
    XCTAssertEqual(maximumStoppingDistance.value,380)
    
    safeties.governorTrippingSpeed = Measurement(value: 1.0, unitSystem: .metric)
    safeties.maximumGovernorTrippingSpeed = Measurement(value: 0.5, unitSystem: .metric)
    safeties.useGovernorTrippingSpeedForStoppingDistance = false
    minimumStoppingDistance = safeties.minimumStoppingDistance
    maximumStoppingDistance = safeties.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance.value, 25)
    XCTAssertEqual(maximumStoppingDistance.value, 380)
    
    safeties.governorTrippingSpeed = Measurement(value:125, unitSystem: .imperial)
    safeties.maximumGovernorTrippingSpeed = Measurement(value: 200, unitSystem: .imperial)
    safeties.useGovernorTrippingSpeedForStoppingDistance = true
    minimumStoppingDistance = safeties.minimumStoppingDistance
    maximumStoppingDistance = safeties.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance.value,1)
    XCTAssertEqual(maximumStoppingDistance.value,15)
    
    safeties.governorTrippingSpeed = Measurement(value: 125, unitSystem: .imperial)
    safeties.maximumGovernorTrippingSpeed = Measurement(value: 200, unitSystem: .imperial)
    safeties.useGovernorTrippingSpeedForStoppingDistance = false
    minimumStoppingDistance = safeties.minimumStoppingDistance
    maximumStoppingDistance = safeties.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance.value, 1)
    XCTAssertEqual(maximumStoppingDistance.value, 15)
  
  }
  
  func testTabulatedStoppingDistance() {
    
    var safeties: SafetiesCodeRequirement
    
    do {
      try safeties = SafetiesCodeRequirement()
    }
    catch {
      fatalError()
    }
    
    safeties.governorTrippingSpeed = Measurement(value: 2.9, unitSystem: .metric)
    safeties.maximumGovernorTrippingSpeed = Measurement(value: 1.0, unitSystem: .metric)
    safeties.useGovernorTrippingSpeedForStoppingDistance = true
    var minimumStoppingDistance = safeties.minimumStoppingDistance
    var maximumStoppingDistance = safeties.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance.value, 430)
    XCTAssertEqual(maximumStoppingDistance.value, 1480)
    
    safeties.governorTrippingSpeed = Measurement(value: 1.0, unitSystem: .metric)
    safeties.maximumGovernorTrippingSpeed = Measurement(value: 2.9, unitSystem: .metric)
    safeties.useGovernorTrippingSpeedForStoppingDistance = false
    minimumStoppingDistance = safeties.minimumStoppingDistance
    maximumStoppingDistance = safeties.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance.value, 430)
    XCTAssertEqual(maximumStoppingDistance.value, 1480)
    
    safeties.governorTrippingSpeed = Measurement(value: 395, unitSystem: .imperial)
    safeties.maximumGovernorTrippingSpeed = Measurement(value: 200, unitSystem: .imperial)
    safeties.useGovernorTrippingSpeedForStoppingDistance = true
    minimumStoppingDistance = safeties.minimumStoppingDistance
    maximumStoppingDistance = safeties.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance.value, 8)
    XCTAssertEqual(maximumStoppingDistance.value, 33)
    
    safeties.governorTrippingSpeed = Measurement(value: 200, unitSystem: .imperial)
    safeties.maximumGovernorTrippingSpeed = Measurement(value: 395, unitSystem: .imperial)
    safeties.useGovernorTrippingSpeedForStoppingDistance = false
    minimumStoppingDistance = safeties.minimumStoppingDistance
    maximumStoppingDistance = safeties.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance.value, 8)
    XCTAssertEqual(maximumStoppingDistance.value, 33)
    
  }

  func testInterpolatedStoppingDistance() {
    
    var safeties: SafetiesCodeRequirement
    
    do {
      try safeties = SafetiesCodeRequirement()
    }
    catch {
      fatalError()
    }
    
    safeties.governorTrippingSpeed = Measurement(value: 3, unitSystem: .metric)
    safeties.maximumGovernorTrippingSpeed = Measurement(value: 1.0, unitSystem: .metric)
    safeties.useGovernorTrippingSpeedForStoppingDistance = true
    var minimumStoppingDistance = safeties.minimumStoppingDistance
    var maximumStoppingDistance = safeties.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance.value, 460)
    XCTAssertEqual(maximumStoppingDistance.value, 1568)
    
    safeties.governorTrippingSpeed = Measurement(value: 1.0, unitSystem: .metric)
    safeties.maximumGovernorTrippingSpeed = Measurement(value: 3, unitSystem: .metric)
    safeties.useGovernorTrippingSpeedForStoppingDistance = false
    minimumStoppingDistance = safeties.minimumStoppingDistance
    maximumStoppingDistance = safeties.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance.value, 460)
    XCTAssertEqual(maximumStoppingDistance.value, 1568)
    
    safeties.governorTrippingSpeed = Measurement(value: 425, unitSystem: .imperial)
    safeties.maximumGovernorTrippingSpeed = Measurement(value: 200, unitSystem: .imperial)
    safeties.useGovernorTrippingSpeedForStoppingDistance = true
    minimumStoppingDistance = safeties.minimumStoppingDistance
    maximumStoppingDistance = safeties.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance.value, 9)
    XCTAssertEqual(maximumStoppingDistance.value, 36)
    
    safeties.governorTrippingSpeed = Measurement(value: 200, unitSystem: .imperial)
    safeties.maximumGovernorTrippingSpeed = Measurement(value: 425, unitSystem: .imperial)
    safeties.useGovernorTrippingSpeedForStoppingDistance = false
    minimumStoppingDistance = safeties.minimumStoppingDistance
    maximumStoppingDistance = safeties.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance.value, 9)
    XCTAssertEqual(maximumStoppingDistance.value, 36)
  }
  
  func testStoppingDistance_atHighSpeed() {
    
    var safeties: SafetiesCodeRequirement
    
    do {
      try safeties = SafetiesCodeRequirement()
    }
    catch {
      fatalError()
    }
    
    safeties.governorTrippingSpeed = Measurement(value:14, unitSystem:.metric)
    safeties.maximumGovernorTrippingSpeed = Measurement(value:10, unitSystem:.metric)
    safeties.useGovernorTrippingSpeedForStoppingDistance = true
    var minimumStoppingDistance = safeties.minimumStoppingDistance
    var maximumStoppingDistance = safeties.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance.value,9984)
    XCTAssertEqual(maximumStoppingDistance.value,28785)
    
    safeties.governorTrippingSpeed = Measurement(value: 10, unitSystem: .metric)
    safeties.maximumGovernorTrippingSpeed = Measurement(value: 14, unitSystem: .metric)
    safeties.useGovernorTrippingSpeedForStoppingDistance = false
    minimumStoppingDistance = safeties.minimumStoppingDistance
    maximumStoppingDistance = safeties.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance.value, 9984)
    XCTAssertEqual(maximumStoppingDistance.value, 28785)
    
    safeties.governorTrippingSpeed = Measurement(value:2600, unitSystem:.imperial)
    safeties.maximumGovernorTrippingSpeed = Measurement(value: 1000, unitSystem: .imperial)
    safeties.useGovernorTrippingSpeedForStoppingDistance = true
    minimumStoppingDistance = safeties.minimumStoppingDistance
    maximumStoppingDistance = safeties.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance.value,349)
    XCTAssertEqual(maximumStoppingDistance.value,1009)
    
    safeties.governorTrippingSpeed = Measurement(value: 1000, unitSystem: .imperial)
    safeties.maximumGovernorTrippingSpeed = Measurement(value: 2600, unitSystem: .imperial)
    safeties.useGovernorTrippingSpeedForStoppingDistance = false
    minimumStoppingDistance = safeties.minimumStoppingDistance
    maximumStoppingDistance = safeties.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance.value, 349)
    XCTAssertEqual(maximumStoppingDistance.value, 1009)
    
  }
    
}
