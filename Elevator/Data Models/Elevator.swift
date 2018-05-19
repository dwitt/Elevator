//
//  Elevator.swift
//  Elevator
//
//  Created by David Witt on 2018-01-25.
//  Copyright © 2018 David Witt. All rights reserved.
//

import Foundation

let conversionFactorFpmToMps: Double = 0.00508

class Elevator {
  var ratedSpeed: MyMeasurement
  var capacity: Double
  var governorSpeedReducingSwitch: Bool
  var staticControl: Bool
  var governorTrippingSpeed: MyMeasurement

  
  init(ratedSpeed: MyMeasurement, capacity: Double, governorSpeedReducingSwitch: Bool, staticControl: Bool) {
    self.ratedSpeed = ratedSpeed
    self.capacity = capacity
    self.governorSpeedReducingSwitch = governorSpeedReducingSwitch
    self.staticControl = staticControl
    
    // self.governorTrippingSpeed = Measurement(value: 0.0, unit: ratedSpeed.unit)
    governorTrippingSpeed = MyMeasurement(of: .speed, value: 0, units: ratedSpeed.units)
  }
  
  
  func updateControlsAreStatic(to state: Bool) {
    staticControl = state
  }
  
  func updateGovernorHasSpeedReducingSwitch(to state: Bool) {
    governorSpeedReducingSwitch = state
  }
    
}


