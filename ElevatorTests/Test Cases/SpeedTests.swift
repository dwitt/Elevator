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
  
  var metricSpeed: Speed!
  var imperialSpeed: Speed!
  
  override func setUp() {
    super.setUp()
    
    metricSpeed = Speed(value: 0.5, units: .metric)
    imperialSpeed = Speed(value: 100, units: .imperial)
    
    
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
    XCTAssertEqual(metricSpeed.unitsAsInt, 0)
  }
  
  func testUnitsAsInt_imperial() {
    XCTAssertEqual(imperialSpeed.unitsAsInt, 1)
  }
  
  func testConvertToCurrentUnits_fromMetric() {
    metricSpeed.units = .imperial
    metricSpeed.convertValueToCurrentUnits()
    
    let conversionResult = 0.5/0.00508
    
    XCTAssertEqual(metricSpeed.value, conversionResult)
  }
  
  func testConvertToCurrentUnits_fromImperial() {
    imperialSpeed.units = .metric
    imperialSpeed.convertValueToCurrentUnits()
    
    let conversionResult = 100 * 0.00508
    
    XCTAssertEqual(imperialSpeed.value, conversionResult)
  }
}
