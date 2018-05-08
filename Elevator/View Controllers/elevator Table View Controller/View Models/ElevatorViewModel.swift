//
//  ElevatorViewModel.swift
//  Elevator
//
//  Created by David Witt on 2018-03-05.
//  Copyright © 2018 David Witt. All rights reserved.
//

import Foundation

struct ElevatorViewModel {
  
  // The viewModel owns the data Model(s)
  
  // MARK: - Properties
  
  private var elevator: Elevator
  
  // viewModel variables
  
  var ratedSpeed: String {
    get {
      return elevator.ratedSpeed.valueAsString
    }
    set(speed) {
      if let speedValue = Double(speed) {
        elevator.ratedSpeed.value = speedValue
      }
    }

  }
  
  var ratedSpeedUnits: Int {
    get {
      return elevator.ratedSpeed.units.rawValue
    }
    set(units) {
      if let ratedSpeedUnits = Units(rawValue: units), elevator.ratedSpeed.units != ratedSpeedUnits {
        elevator.ratedSpeed.units = ratedSpeedUnits
        elevator.ratedSpeed.convertValueToCurrentUnits()
      }
    }
  }
  
  var governorTrippingSpeed: String {
    get {
      return elevator.governorTrippingSpeed.valueAsString
    }
    set(speed) {
      if let speedValue = Double(speed) {
        elevator.governorTrippingSpeed.value = speedValue
      }
    }
  }
  
  var governorTrippingSpeedUnits: Int {
    get {
      return elevator.governorTrippingSpeed.units.rawValue
    }
    set(units) {
      if let governorTrippingSpeedUnits = Units(rawValue: units), elevator.governorTrippingSpeed.units != governorTrippingSpeedUnits {
        elevator.governorTrippingSpeed.units = governorTrippingSpeedUnits
        elevator.governorTrippingSpeed.convertValueToCurrentUnits()
      }
    }
  }
  
  // MARK: - Initializer
  
  init(_ elevator: Elevator) {
    self.elevator = elevator
  }
  
  // MARK: - Public Interface

  func createGovernorInspectionViewModel() -> GovernorInspectionViewModel{
    let viewModel = GovernorInspectionViewModel(elevator: self.elevator)
    return viewModel
  }
  
  // MARK: - Helper Functions
  


  
}
