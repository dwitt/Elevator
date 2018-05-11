//
//  helperFunctions.swift
//  Elevator
//
//  Created by David Witt on 2018-03-17.
//  Copyright © 2018 David Witt. All rights reserved.
//

import Foundation

enum MeasurementParameter: Int {
  case distance = 0
  case speed = 1
  case acceleration = 2
  
}

  struct Measurement {
    var value: Double = 0.0
    var unitSystem: UnitSystem = .metric {
      willSet {
        previousUnitSystem = unitSystem
      }
    }
    var parameter: MeasurementParameter
    
    private var previousUnitSystem: UnitSystem = .metric
    
    private let conversionFactorToMetric: Double
    
    init(value: Double, units: UnitSystem, parameter: MeasurementParameter) {
      self.value = value
      self.unitSystem = units
      self.parameter = parameter
      
      switch parameter {
      case .distance:
        // Units are in and mm
        conversionFactorToMetric = 2.54
      case .speed:
        // Units are fpm and mps
        conversionFactorToMetric = 0.00508
      case .acceleration:
        // Units are unknown at this time
        conversionFactorToMetric = 1.0
        
      }
      
    }
    
    mutating func convertValueToCurrentUnits() {
      if unitSystem != previousUnitSystem {
        switch unitSystem {
        case .metric:
          value = value * conversionFactorFpmToMps
        case .imperial:
          value = value / conversionFactorFpmToMps
        }
      }
    }
    
    var valueAsString : String {
      get {
        switch unitSystem {
        case .metric:
          return String(format: "%.2f", value)
        case .imperial:
          return String(format: "%.0f", value)
        }
      }
      set {
        if let newSpeedValue = Double(newValue) {
          value = newSpeedValue
        }
      }
    }
    
    var unitsAsInt : Int {
      get {
        return (unitSystem.rawValue)
      }
      set {
        if let newUnits = UnitSystem(rawValue: newValue), newUnits != unitSystem {
          unitSystem = newUnits
          convertValueToCurrentUnits()
        }
      }
    }
    
    
    
}
    

  

