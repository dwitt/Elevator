//
//  ElevatorInspectionDataModelController.swift
//  Elevator
//
//  Created by David Witt on 2018-01-30.
//  Copyright © 2018 David Witt. All rights reserved.
//

import Foundation



class ElevatorInspectionStateController {
    
  var elevator: Elevator
  var code: ElevatorCode
  var inspector: Inspector
  
  init () {
    // create an elevator
    // TODO: change this initializer to create an empty elevator
    elevator = Elevator(ratedSpeed: Speed(value: 0.5, units: .metric), capacity: 1361, governorHasSpeedReducingSwitch: false, staticControl: true, governorTrippingSpeed: 0)
    code = ElevatorCode()
    inspector = Inspector()
  }
  
  func updateRatedSpeed(to speed: Double) {
    elevator.ratedSpeed = speed
  }
  
  func getElevator() -> Elevator {
    return elevator
  }
  
  func getCode() -> ElevatorCode {
    return code
  }
  
  func getInspector() -> Inspector {
    return inspector
  }
  
  func changeUnits(to newUnits: Units, with rounding: Bool) {
    
    // Tell the elevator to convert to new units
    elevator.convert(to: newUnits, with: rounding)
    
  }
  
  func changeElevatorRatedSpeed(to newSpeed: Double, in units: Units) {
    elevator.changeRatedSpeed(to: newSpeed, in: units)
  }
    
  func changeElevatorRatedSpeedUnits(to units: Units) {
    elevator.units = units
  }
    
}
