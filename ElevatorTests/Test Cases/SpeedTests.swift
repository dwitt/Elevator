//
//  SpeedTests.swift
//  ElevatorTests
//
//  Created by David Witt on 2018-04-01.
//  Copyright © 2018 David Witt. All rights reserved.
//

import XCTest
@testable import Elevator

class SpeedTests: XCTestCase {
  
  var metricSpeed: Measurement<UnitSpeed>!
  var imperialSpeed: Measurement<UnitSpeed>!
  
  override func setUp() {
    super.setUp()
    
    metricSpeed = Measurement(value: 0.5, unit: UnitSystem.metric.speed)
    imperialSpeed = Measurement(value: 100, unit: UnitSystem.imperial.speed)
    
    
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testValueAsString_metric() {
    XCTAssertEqual(metricSpeed.valueAsString, "0.50")
  }
  
  func testValueAsString_imperial() {
    XCTAssertEqual(imperialSpeed.valueAsString, "100")
  }
  
  func testUnitsAsInt_metric() {
    XCTAssertEqual(metricSpeed.unitSystem, UnitSystem(rawValue: 0))
  }
  
  func testUnitsAsInt_imperial() {
    XCTAssertEqual(imperialSpeed.unitSystem, UnitSystem(rawValue: 1))
  }
  
  func testConvertToCurrentUnits_fromMetric() {
    metricSpeed.convert(to: UnitSystem.imperial)
    
    let conversionResult = 0.5/0.00508
    
    XCTAssertEqual(metricSpeed.value, conversionResult)
  }
  
  func testConvertToCurrentUnits_fromImperial() {
    imperialSpeed.convert(to: UnitSystem.metric)
    
    let conversionResult = 100 * 0.00508
    
    XCTAssertEqual(imperialSpeed.value, conversionResult)
  }
}
