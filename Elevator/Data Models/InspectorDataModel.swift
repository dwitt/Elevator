//
//  InspectorDataModel.swift
//  Elevator
//
//  Created by David Witt on 2018-02-08.
//  Copyright © 2018 David Witt. All rights reserved.
//

import Foundation

// Model of the Elevator Inspector
// Provides functions that a real world inspector would perform to help make descisions

struct Inspector {
  
  
  // Assist the inspector in determining what speed to use when checking the governor
  
  func elevatorRatedSpeedForGovernorSetting(forElevatorRatedSpeed elevatorRatedSpeed: Speed, usingTabulatedSpeeds tabulatedEquivalentSpeeds: Bool, resultInUnits governorSpeedUnits: Units ) -> Speed {
    
    var ratedSpeed: Double
    
    // Return a rated speed to lookup in the code book
    // Take the actual elevator rated speed, units and tabulated flag to determine
    // the requested lookup speed
    
    // Start by converting the elevator speed to the correct units

    if elevatorRatedSpeed.units != governorSpeedUnits {
      // Convert the speed to the correct units
      if governorSpeedUnits == .metric {
        ratedSpeed = elevatorRatedSpeed.value * conversionFactorFpmToMps
      } else {
        ratedSpeed = elevatorRatedSpeed.value  / conversionFactorFpmToMps
      }
    } else {
      // No conversion required
      ratedSpeed = elevatorRatedSpeed.value
    }
  
        
    // Check if the inspector wants to use tabulated values
    if tabulatedEquivalentSpeeds {
      
      // Check which units are selected so that we can use the correct tabulation
      
      if governorSpeedUnits == .metric {
        let speeds: [Double]  = [0.63, 0.75, 0.87, 1.00, 1.12, 1.25, 1.50, 1.75, 2.00, 2.25,
                                 2.50, 3.00, 3.50, 4.00, 4.50, 5.00, 5.50, 6.00, 6.50, 7.00,
                                 7.50, 8.00, 8.50, 9.00, 10.00]
        
        // Determine which tabulated value is closest to our value
        if let closest = speeds.enumerated().min(by: { abs($0.1 - ratedSpeed) < abs($1.1 - ratedSpeed)}) {
          
          // Determine the percentage difference from the rated speed
          let percentDeviation = abs((closest.element - ratedSpeed) / ratedSpeed)
          
          // Check how far we are from the tabulated speeds. Within 2% means we can use the tabulated speeds.
          // At 2% the metric and imperial numbers will be considered the same as this is the just more than
          // the actual difference between the units converted value and the table value
          
          if percentDeviation < 0.02 {
            return Speed(value: closest.element, units: governorSpeedUnits)
          }
          
          return Speed(value: ratedSpeed, units: governorSpeedUnits)
        }
        
      } else {
        let speeds: [Double] = [ 125, 150, 175, 200, 225, 250, 300, 350, 400, 450,
                                 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400,
                                 1500, 1600, 1700, 1800, 1900, 2000]
        
        // Determine which tabulated value is closest to our value
        if let closest = speeds.enumerated().min(by: { abs($0.1 - ratedSpeed) < abs($1.1 - ratedSpeed)}) {
          
          // Determine the percentage difference from the rated speed
          let percentDeviation = abs((closest.element - ratedSpeed) / ratedSpeed)
          
          // Check how far we are from the tabulated speeds. Within 2% means we can use the tabulated speeds.
          // At 2% the metric and imperial numbers will be considered the same as this is the just more than
          // the actual difference between the units converted value and the table value
          
          if percentDeviation < 0.02 {
            return Speed(value: closest.element, units: governorSpeedUnits)
          }
          
          return Speed(value: ratedSpeed, units: governorSpeedUnits)
        }
      }
    }
    return Speed(value: ratedSpeed, units: governorSpeedUnits)
    }
}
