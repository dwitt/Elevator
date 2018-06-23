//
//  TypeBSafetyInspectionViewModel.swift
//  Elevator
//
//  Created by David Witt on 2018-05-08.
//  Copyright © 2018 David Witt. All rights reserved.
//

import Foundation

struct TypeBSafetyInspectionViewModel {
  
  // The ViewModel owns the Model(s)
  
  // MARK: - Private Models
  
  private var elevator: Elevator
  private var code: ElevatorCode = ElevatorCode()
  private var inpsector: Inspector = Inspector()
  
  
  // MARK: - Public Properties
  
  var maximumSafetySlide: Measurement<UnitLength>
  var minimumSafetySlide: Measurement<UnitLength>
  var governorTrippingSpeed: Measurement<UnitSpeed>
  
  // MARK: Computed Public Properties
  
  var ratedSpeedForSafetySlide: Measurement<UnitSpeed> {
    didSet {
      ratedSpeedForSafetySlide = inpsector.elevatorRatedSpeedForGovernorSetting(forElevatorRatedSpeed: elevator.ratedSpeed, usingTabulatedSpeeds: tabulatedEquivalentSpeeds, resultInUnits: self.ratedSpeedForSafetySlide.unit)
      
      code.governor.elevatorRatedSpeed = ratedSpeedForSafetySlide
      maximumGovernorTrippingSpeed = code.governor.maximumTrippingSpeed
      code.safeties.maximumGovernorTrippingSpeed = maximumGovernorTrippingSpeed
      
      if slideCalulationBasedOnMaximumGovernorTrippingSpeed == false {
        convertSlideDistanceTo(unitSystem: elevator.governorTrippingSpeed.unitSystem)
      }
      
    }
  }
  var tabulatedEquivalentSpeeds: Bool {
    didSet {
            ratedSpeedForSafetySlide = inpsector.elevatorRatedSpeedForGovernorSetting(forElevatorRatedSpeed: elevator.ratedSpeed, usingTabulatedSpeeds: tabulatedEquivalentSpeeds, resultInUnits: self.ratedSpeedForSafetySlide.unit)
      
    
      code.governor.elevatorRatedSpeed = ratedSpeedForSafetySlide    
      maximumGovernorTrippingSpeed = code.governor.maximumTrippingSpeed
      code.safeties.maximumGovernorTrippingSpeed = maximumGovernorTrippingSpeed
    }
  }
  
  var maximumGovernorTrippingSpeed: Measurement<UnitSpeed> {
    didSet {
      if slideCalulationBasedOnMaximumGovernorTrippingSpeed == true {
        convertSlideDistanceTo(unitSystem: maximumGovernorTrippingSpeed.unitSystem)
      }
    }
  }
    
  var slideCalulationBasedOnMaximumGovernorTrippingSpeed: Bool {
    didSet {
      code.safeties.useGovernorTrippingSpeedForStoppingDistance = !slideCalulationBasedOnMaximumGovernorTrippingSpeed
      maximumSafetySlide = code.safeties.maximumStoppingDistance
      minimumSafetySlide = code.safeties.minimumStoppingDistance
      
      if slideCalulationBasedOnMaximumGovernorTrippingSpeed == true {
        convertSlideDistanceTo(unitSystem: maximumGovernorTrippingSpeed.unitSystem)
      } else {
        convertSlideDistanceTo(unitSystem: elevator.governorTrippingSpeed.unitSystem)
      }
      
    }
  }

  
  var elevatorRatedSpeed: Measurement<UnitSpeed> {
    return elevator.ratedSpeed
  }
  
  // MARK: - Initializer
  
  init(elevator: Elevator) {
    
    self.elevator = elevator
    
    ratedSpeedForSafetySlide = elevator.ratedSpeed
    
    // MARK: Initialize the Governor Code Model

    code.governor.actualTrippingSpeed = elevator.governorTrippingSpeed
    code.governor.elevatorRatedSpeed = ratedSpeedForSafetySlide
    
    // MARK: Initialize the Safeties Code Model
    
    code.safeties.governorTrippingSpeed = elevator.governorTrippingSpeed
    code.safeties.maximumGovernorTrippingSpeed = code.governor.maximumTrippingSpeed
    
    // MARK: Initialize the View Model
    
    governorTrippingSpeed = elevator.governorTrippingSpeed
    
    tabulatedEquivalentSpeeds = true
    maximumGovernorTrippingSpeed = code.governor.maximumTrippingSpeed
    slideCalulationBasedOnMaximumGovernorTrippingSpeed = false
    code.safeties.useGovernorTrippingSpeedForStoppingDistance = !slideCalulationBasedOnMaximumGovernorTrippingSpeed
    maximumSafetySlide = code.safeties.maximumStoppingDistance
    minimumSafetySlide = code.safeties.minimumStoppingDistance
    
  }
  
  // MARK: - Private methods
  
  private mutating func convertSlideDistanceTo(unitSystem: UnitSystem) {
    maximumSafetySlide.convert(to: unitSystem.length )
    minimumSafetySlide.convert(to: unitSystem.length )
  }
}
