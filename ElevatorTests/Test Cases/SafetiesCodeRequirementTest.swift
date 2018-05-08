//
//  SafetiesCodeRequirementTest.swift
//  ElevatorTests
//
//  Created by David Witt on 2018-04-08.
//  Copyright © 2018 David Witt. All rights reserved.
//

import XCTest
@testable import Elevator

  var safeties = SafetiesCodeRequirement()

class SafetiesCodeRequirementTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
      
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
  func testInit() {
    let safeties = SafetiesCodeRequirement()
    XCTAssertNotNil(safeties)

  }
  
  func testStoppingDistance_atLowSpeed() {
    safeties!.governorTrippingSpeed = Speed(value:0.5,units:.metric)
    safeties!.maximumGovernorTrippingSpeed = Speed(value:1.0,units:.metric)
    safeties!.useGovernorTrippingSpeedForStoppingDistance = true
    var minimumStoppingDistnce = safeties!.minimumStoppingDistance
    var maximumStoppingDistnce = safeties!.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistnce,25)
    XCTAssertEqual(maximumStoppingDistnce,380)
    
    safeties!.governorTrippingSpeed = Speed(value: 1.0, units: .metric)
    safeties!.maximumGovernorTrippingSpeed = Speed(value: 0.5, units: .metric)
    safeties!.useGovernorTrippingSpeedForStoppingDistance = false
    minimumStoppingDistnce = safeties!.minimumStoppingDistance
    maximumStoppingDistnce = safeties!.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistnce, 25)
    XCTAssertEqual(maximumStoppingDistnce, 380)
    
    safeties!.governorTrippingSpeed = Speed(value:125, units:.imperial)
    safeties!.maximumGovernorTrippingSpeed = Speed(value: 200, units: .imperial)
    safeties!.useGovernorTrippingSpeedForStoppingDistance = true
    minimumStoppingDistnce = safeties!.minimumStoppingDistance
    maximumStoppingDistnce = safeties!.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistnce,1)
    XCTAssertEqual(maximumStoppingDistnce,15)
    
    safeties!.governorTrippingSpeed = Speed(value: 125, units: .imperial)
    safeties!.maximumGovernorTrippingSpeed = Speed(value: 200, units: .imperial)
    safeties!.useGovernorTrippingSpeedForStoppingDistance = false
    minimumStoppingDistnce = safeties!.minimumStoppingDistance
    maximumStoppingDistnce = safeties!.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistnce, 1)
    XCTAssertEqual(maximumStoppingDistnce, 15)
  
  }
  
  func testTabulatedStoppingDistance() {
    safeties!.governorTrippingSpeed = Speed(value: 2.9, units: .metric)
    safeties!.maximumGovernorTrippingSpeed = Speed(value: 1.0, units: .metric)
    safeties!.useGovernorTrippingSpeedForStoppingDistance = true
    var minimumStoppingDistance = safeties!.minimumStoppingDistance
    var maximumStoppingDistance = safeties!.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance, 430)
    XCTAssertEqual(maximumStoppingDistance, 1480)
    
    safeties!.governorTrippingSpeed = Speed(value: 1.0, units: .metric)
    safeties!.maximumGovernorTrippingSpeed = Speed(value: 2.9, units: .metric)
    safeties!.useGovernorTrippingSpeedForStoppingDistance = false
    minimumStoppingDistance = safeties!.minimumStoppingDistance
    maximumStoppingDistance = safeties!.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance, 430)
    XCTAssertEqual(maximumStoppingDistance, 1480)
    
    safeties!.governorTrippingSpeed = Speed(value: 395, units: .imperial)
    safeties!.maximumGovernorTrippingSpeed = Speed(value: 200, units: .imperial)
    safeties!.useGovernorTrippingSpeedForStoppingDistance = true
    minimumStoppingDistance = safeties!.minimumStoppingDistance
    maximumStoppingDistance = safeties!.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance, 8)
    XCTAssertEqual(maximumStoppingDistance, 33)
    
    safeties!.governorTrippingSpeed = Speed(value: 200, units: .imperial)
    safeties!.maximumGovernorTrippingSpeed = Speed(value: 395, units: .imperial)
    safeties!.useGovernorTrippingSpeedForStoppingDistance = false
    minimumStoppingDistance = safeties!.minimumStoppingDistance
    maximumStoppingDistance = safeties!.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance, 8)
    XCTAssertEqual(maximumStoppingDistance, 33)
    
  }

  func testInterpolatedStoppingDistance() {
    safeties!.governorTrippingSpeed = Speed(value: 3, units: .metric)
    safeties!.maximumGovernorTrippingSpeed = Speed(value: 1.0, units: .metric)
    safeties!.useGovernorTrippingSpeedForStoppingDistance = true
    var minimumStoppingDistance = safeties!.minimumStoppingDistance
    var maximumStoppingDistance = safeties!.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance, 460)
    XCTAssertEqual(maximumStoppingDistance, 1568)
    
    safeties!.governorTrippingSpeed = Speed(value: 1.0, units: .metric)
    safeties!.maximumGovernorTrippingSpeed = Speed(value: 3, units: .metric)
    safeties!.useGovernorTrippingSpeedForStoppingDistance = false
    minimumStoppingDistance = safeties!.minimumStoppingDistance
    maximumStoppingDistance = safeties!.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance, 460)
    XCTAssertEqual(maximumStoppingDistance, 1568)
    
    safeties!.governorTrippingSpeed = Speed(value: 425, units: .imperial)
    safeties!.maximumGovernorTrippingSpeed = Speed(value: 200, units: .imperial)
    safeties!.useGovernorTrippingSpeedForStoppingDistance = true
    minimumStoppingDistance = safeties!.minimumStoppingDistance
    maximumStoppingDistance = safeties!.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance, 9)
    XCTAssertEqual(maximumStoppingDistance, 36)
    
    safeties!.governorTrippingSpeed = Speed(value: 200, units: .imperial)
    safeties!.maximumGovernorTrippingSpeed = Speed(value: 425, units: .imperial)
    safeties!.useGovernorTrippingSpeedForStoppingDistance = false
    minimumStoppingDistance = safeties!.minimumStoppingDistance
    maximumStoppingDistance = safeties!.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance, 9)
    XCTAssertEqual(maximumStoppingDistance, 36)
  }
  
  func testStoppingDistance_atHighSpeed() {
    safeties!.governorTrippingSpeed = Speed(value:14,units:.metric)
    safeties!.maximumGovernorTrippingSpeed = Speed(value:10,units:.metric)
    safeties!.useGovernorTrippingSpeedForStoppingDistance = true
    var minimumStoppingDistance = safeties!.minimumStoppingDistance
    var maximumStoppingDistance = safeties!.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance,9984)
    XCTAssertEqual(maximumStoppingDistance,28785)
    
    safeties!.governorTrippingSpeed = Speed(value: 10, units: .metric)
    safeties!.maximumGovernorTrippingSpeed = Speed(value: 14, units: .metric)
    safeties!.useGovernorTrippingSpeedForStoppingDistance = false
    minimumStoppingDistance = safeties!.minimumStoppingDistance
    maximumStoppingDistance = safeties!.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance, 9984)
    XCTAssertEqual(maximumStoppingDistance, 28785)
    
    safeties!.governorTrippingSpeed = Speed(value:2600, units:.imperial)
    safeties!.maximumGovernorTrippingSpeed = Speed(value: 1000, units: .imperial)
    safeties!.useGovernorTrippingSpeedForStoppingDistance = true
    minimumStoppingDistance = safeties!.minimumStoppingDistance
    maximumStoppingDistance = safeties!.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance,349)
    XCTAssertEqual(maximumStoppingDistance,1009)
    
    safeties!.governorTrippingSpeed = Speed(value: 1000, units: .imperial)
    safeties!.maximumGovernorTrippingSpeed = Speed(value: 2600, units: .imperial)
    safeties!.useGovernorTrippingSpeedForStoppingDistance = false
    minimumStoppingDistance = safeties!.minimumStoppingDistance
    maximumStoppingDistance = safeties!.maximumStoppingDistance
    XCTAssertEqual(minimumStoppingDistance, 349)
    XCTAssertEqual(maximumStoppingDistance, 1009)
    
  }
    
}
