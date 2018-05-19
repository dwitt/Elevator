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

  struct MyMeasurement {
    
    // MARK: - Public properties
    
    var value: Double = 0.0
    var units: UnitSystem = .metric {
      willSet {
        previousUnitSystem = units
      }
    }
    var parameter: MeasurementParameter
    
    // MARK: - Private properties
    
    private var previousUnitSystem: UnitSystem = .metric
    
    private let conversionFactorToMetric: Double
    
    // MARK: - Initializer
    
    init(of parameter: MeasurementParameter, value: Double, units: UnitSystem) {
//      self.init(value: value, units: units, parameter: parameter)
//    }
    
//    init(value: Double, units: UnitSystem, parameter: MeasurementParameter) {
      self.value = value
      self.units = units
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
    
    // MARK: - Public methods
    
    mutating func convertValueToCurrentUnits() {
      if units != previousUnitSystem {
        switch units {
        case .metric:
          value = value * conversionFactorFpmToMps
        case .imperial:
          value = value / conversionFactorFpmToMps
        }
      }
    }
    
    var valueAsString : String {
      get {
        switch units {
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
        return (units.rawValue)
      }
      set {
        if let newUnits = UnitSystem(rawValue: newValue), newUnits != units {
          units = newUnits
          convertValueToCurrentUnits()
        }
      }
    }
    
    
    
}
    

  

