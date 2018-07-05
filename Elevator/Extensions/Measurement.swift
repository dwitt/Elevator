//
//  Measurement.swift
//  Elevator
//
//  Created by David Witt on 2018-05-20.
//  Copyright © 2018 David Witt. All rights reserved.
//

import Foundation

// MARK: - Measurement Extension for UnitSpeed

extension Measurement where UnitType: UnitSpeed {
  
  // MARK: - Initializers
  
  init(value: String?, unitSystem: UnitSystem) {
    var unitType: UnitType
    var doubleValue: Double
    
    switch unitSystem {
    case .metric:
      unitType = UnitSpeed.metersPerSecond as! UnitType
    case .imperial:
      unitType = UnitSpeed.feetPerMinute as! UnitType
    default:
      unitType =  UnitSpeed.metersPerSecond as! UnitType
    }
    
    if let value = value {
      doubleValue = Double(value) ?? 0.0
    } else {
      doubleValue = 0.0
    }
    
    self.init(value: doubleValue, unit: unitType)
  }
  
  init(value: Double, unitSystem: UnitSystem) {
    var unitType: UnitType
    
    switch unitSystem {
    case .metric:
      unitType = UnitSpeed.metersPerSecond as! UnitType
    case .imperial:
      unitType = UnitSpeed.feetPerMinute as! UnitType
    default:
      unitType =  UnitSpeed.metersPerSecond as! UnitType
    }
    
    self.init(value: value, unit: unitType)
  }

  // MARK: - Public Properties
  
  var valueAsString : String {
    get {
      switch self.unitSystem {
      case .metric:
        return String(format: "%.2f", value)
      case .imperial:
        return String(format: "%.0f", value)
      default:
        return String(value)
      }
    }
    set {
      if let newSpeedValue = Double(newValue) {
        value = newSpeedValue
      }
    }
  }
  
  var unitSystem: UnitSystem {
    get {
      var system: UnitSystem
      
      switch self.unit.symbol {
      case "m/s":
        system = UnitSystem.metric
      case "km/h":
        system = UnitSystem.metric
      case "mph":
        system = UnitSystem.metric
      case "fpm":
        system = UnitSystem.imperial
      default:
        system = UnitSystem.unknown
      }
      return system
    }
  }

  // MARK: - Public Methods
  
  mutating func convert(to otherUnitSystem: UnitSystem) {
    switch otherUnitSystem {
    case .metric:
      self.convert(to: UnitSpeed.metersPerSecond as! UnitType)
    case .imperial:
      self.convert(to: UnitSpeed.feetPerMinute as! UnitType)
    case .unknown:
      break
    }
  }
  
  
}

// MARK: - Measurement Extension for UnitLength

extension Measurement where UnitType: UnitLength {
  
  var valueAsString : String {
    get {
      switch self.unitSystem {
      case .metric:
        return String(format: "%.0f", value)
      case .imperial:
        return String(format: "%.0f", value)
      default:
        return String(value)
      }
    }
    set {
      if let newSpeedValue = Double(newValue) {
        value = newSpeedValue
      }
    }
  }
  
  var unitSystem: UnitSystem {
    get {
      var system: UnitSystem
      
      switch self.unit.symbol {
      case "mm":
        system = UnitSystem.metric
      case "in":
        system = UnitSystem.imperial
      default:
        system = UnitSystem.unknown
      }
      return system
    }
  }
  
  // MARK: - Public Methods
  
  mutating func convert(to otherUnitSystem: UnitSystem) {
    switch otherUnitSystem {
    case .metric:
      self.convert(to: UnitLength.millimeters as! UnitType)
    case .imperial:
      self.convert(to: UnitLength.inches as! UnitType)
    case .unknown:
      break
    }
  }
}
