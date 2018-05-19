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
  
  // MARK: - Properties
  

  var ratedSpeedForSafetySlide: MyMeasurement
  var tabulatedEquivalentSpeeds: Bool
  var maximumGovernorTrippingSpeed: MyMeasurement
  var slideCalulationBasedOnMaximumGovernorTrippingSpeed: Bool
  var maximumSafetySlide: MeasurementParameter
  var minimumSafetySlide: MeasurementParameter
  
}
