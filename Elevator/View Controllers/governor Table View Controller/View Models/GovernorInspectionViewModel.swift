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
      elevatorRatedSpeedForGovernorSetting = inspector.elevatorRatedSpeedForGovernorSetting(forElevatorRatedSpeed: elevator.ratedSpeed, usingTabulatedSpeeds: tabulatedEquivalentSpeeds, resultInUnits: elevatorRatedSpeedForGovernorSetting.units)
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
  
  var elevatorRatedSpeed: MyMeasurement {
    get {
      return elevator.ratedSpeed
    }
  }
  
  var governorTrippingSpeed: MyMeasurement {
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
  
  // MARK: - MyMeasurement Variables

  var elevatorRatedSpeedForGovernorSetting: MyMeasurement {
    didSet {
      
      elevatorRatedSpeedForGovernorSetting = inspector.elevatorRatedSpeedForGovernorSetting(forElevatorRatedSpeed: elevator.ratedSpeed, usingTabulatedSpeeds: tabulatedEquivalentSpeeds, resultInUnits: elevatorRatedSpeedForGovernorSetting.units
      )
      
      code.governor.elevatorRatedSpeed = elevatorRatedSpeedForGovernorSetting
      governorMaximumTrippingSpeed = code.governor.maximumTrippingSpeed
      governorMinimumTrippingSpeed = code.governor.minimumTrippingSpeed
      
      governorTrippingSpeed.unitsAsInt = elevatorRatedSpeedForGovernorSetting.units.rawValue

    }
  }

  var governorMaximumTrippingSpeed: MyMeasurement
  var governorMinimumTrippingSpeed: MyMeasurement
  var governorOverspeedSwitchMaximumTrippingSpeed: MyMeasurement
  var governorSpeedReducingSwitchMaximumTrippingSpeed: MyMeasurement
  
  // MARK: - Initializer
  
  init(elevator: Elevator) {
    
    self.elevator = elevator
    
    //elevator.governorTrippingSpeed.unit = elevator.ratedSpeed.unit
    //elevator.governorTrippingSpeed.convertValueToCurrentUnits()
    
    elevatorRatedSpeedForGovernorSetting = elevator.ratedSpeed
    
    // TODO: - adjust all of the unit to match the rated MyMeasurement
    // elevator.governorTrippingSpeed
    // 
    
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
    governorMaximumTrippingSpeed.units = governorTrippingSpeed.units
    governorMaximumTrippingSpeed.convertValueToCurrentUnits()
    governorMinimumTrippingSpeed.units = governorTrippingSpeed.units
    governorMinimumTrippingSpeed.convertValueToCurrentUnits()
    
  }
  
}



