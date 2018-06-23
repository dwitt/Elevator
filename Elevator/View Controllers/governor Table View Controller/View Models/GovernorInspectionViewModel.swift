//
//  GovernorInspectionViewModel.swift
//  Elevator
//
//  Created by David Witt on 2018-02-10.
//  Copyright © 2018 David Witt. All rights reserved.
//

import Foundation

struct GovernorInspectionViewModel {

  // The viewModels owns the Model(s)

  // MARK: - Models
  
  private var elevator: Elevator
  private var code: ElevatorCode = ElevatorCode()
  private var inspector: Inspector = Inspector()
  
  // MARK: - Properties
  
  var tabulatedEquivalentSpeeds: Bool {
    didSet {
      elevatorRatedSpeedForGovernorSetting = inspector.elevatorRatedSpeedForGovernorSetting(forElevatorRatedSpeed: elevator.ratedSpeed, usingTabulatedSpeeds: tabulatedEquivalentSpeeds, resultInUnits: elevatorRatedSpeedForGovernorSetting.unit)
      }
  }
  
  // MARK: - Computed Properties

  var staticControl: Bool {
    get {
      return elevator.staticControl
    }
    set {
      elevator.staticControl = newValue
      code.governor.staticControl = newValue
      updateSwitchSpeeds()
    }
  }
  
  var speedReducingSwitch: Bool {
    get {
      return elevator.governorSpeedReducingSwitch
    }
    set {
      elevator.governorSpeedReducingSwitch = newValue
      code.governor.speedReducingSwitch = newValue
      updateSwitchSpeeds()
    }
  }
  
  var elevatorRatedSpeed: Measurement<UnitSpeed> {
    get {
      return elevator.ratedSpeed
    }
  }
  
  var governorTrippingSpeed: Measurement<UnitSpeed> {
    get {
      return elevator.governorTrippingSpeed
    }
    set {
      elevator.governorTrippingSpeed = newValue
      code.governor.actualTrippingSpeed = newValue
      updateMaxMinToMatchTrippingSpeedUnits()
      updateSwitchSpeeds()
    }
  }
  
  var governorTrippingSpeedInAcceptableRange: Bool {
    if governorTrippingSpeed <= governorMaximumTrippingSpeed && governorTrippingSpeed >= governorMinimumTrippingSpeed {
      return true
    } else {
      return false
    }
  }
  
  // MARK: - MyMeasurement Variables

  var elevatorRatedSpeedForGovernorSetting: Measurement<UnitSpeed> {
    didSet {
      
      elevatorRatedSpeedForGovernorSetting = inspector.elevatorRatedSpeedForGovernorSetting(forElevatorRatedSpeed: elevator.ratedSpeed, usingTabulatedSpeeds: tabulatedEquivalentSpeeds, resultInUnits: elevatorRatedSpeedForGovernorSetting.unit)
      
      code.governor.elevatorRatedSpeed = elevatorRatedSpeedForGovernorSetting
      
      governorMaximumTrippingSpeed = code.governor.maximumTrippingSpeed
      governorMinimumTrippingSpeed = code.governor.minimumTrippingSpeed
      
      
      // MARK: - Set the units based on the unit system
      governorTrippingSpeed.convert(to: elevatorRatedSpeedForGovernorSetting.unit)

    }
  }

  var governorMaximumTrippingSpeed: Measurement<UnitSpeed>
  var governorMinimumTrippingSpeed: Measurement<UnitSpeed>
  var governorOverspeedSwitchMaximumTrippingSpeed: Measurement<UnitSpeed>
  var governorSpeedReducingSwitchMaximumTrippingSpeed: Measurement<UnitSpeed>
  
  // MARK: - Initializer
  
  init(elevator: Elevator) {
    
    self.elevator = elevator
    
    elevatorRatedSpeedForGovernorSetting = elevator.ratedSpeed
    
    // MARK: Initialize the Governor Code Model
    
    code.governor.speedReducingSwitch = elevator.governorSpeedReducingSwitch
    code.governor.staticControl = elevator.staticControl
    code.governor.actualTrippingSpeed = elevator.governorTrippingSpeed
    code.governor.elevatorRatedSpeed = elevatorRatedSpeedForGovernorSetting
    
    // MARK: Initialze the View Model Properties
    
    elevatorRatedSpeedForGovernorSetting = elevator.ratedSpeed
    
    tabulatedEquivalentSpeeds = true
    
    governorMaximumTrippingSpeed = code.governor.maximumTrippingSpeed
    governorMinimumTrippingSpeed = code.governor.minimumTrippingSpeed
    governorOverspeedSwitchMaximumTrippingSpeed = code.governor.overSpeedSwitchTrippingSpeed
    governorSpeedReducingSwitchMaximumTrippingSpeed = code.governor.speedReducingSwitchTrippingSpeed
    
  }
  
  private mutating func updateSwitchSpeeds() {
    governorOverspeedSwitchMaximumTrippingSpeed = code.governor.overSpeedSwitchTrippingSpeed
    governorSpeedReducingSwitchMaximumTrippingSpeed = code.governor.speedReducingSwitchTrippingSpeed
  }
  
  private mutating func updateMaxMinToMatchTrippingSpeedUnits() {
    governorMaximumTrippingSpeed.convert(to: governorTrippingSpeed.unit)
    governorMinimumTrippingSpeed.convert(to: governorTrippingSpeed.unit)

    
  }
  
}



