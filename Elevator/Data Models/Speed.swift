//
//  helperFunctions.swift
//  Elevator
//
//  Created by David Witt on 2018-03-17.
//  Copyright © 2018 David Witt. All rights reserved.
//

import Foundation

  struct Speed {
    var value: Double = 0.0
    var units: Units = .metric {
      willSet {
        previousUnits = units
      }
    }
    private var previousUnits: Units = .metric
    
    private let conversionFactorFpmToMps: Double = 0.00508
    
    init(value: Double, units: Units) {
      self.value = value
      self.units = units
    }
    
    mutating func convertValueToCurrentUnits() {
      if units != previousUnits {
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
        if let newUnits = Units(rawValue: newValue), newUnits != units {
          units = newUnits
          convertValueToCurrentUnits()
        }
      }
    }
    
    
    
}
    

  

