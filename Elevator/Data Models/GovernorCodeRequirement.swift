//
//  GovernorRequirement.swift
//  Elevator
//
//  Created by David Witt on 2018-03-18.
//  Copyright © 2018 David Witt. All rights reserved.
//

import Foundation

struct GovernorCodeRequirement {
  
  // MARK: - Tabular Data from the A17.1 Code
  // Store the tabular data form A17.1-2010 for governor tripping speed
  // For the metric data the values are multiplied by 100 (cm/s instead of m/s)
  //      to minimize the variable size for storage
  
  private let metricTabulatedTrippingSpeed: [Int : Int] = [
    63  : 90,
    75  : 105,
    87  : 125,
    100 : 140,
    112 : 155,
    125 : 170,
    150 : 200,
    175 : 230,
    200 : 255,
    225 : 290,
    250 : 315,
    300 : 370,
    350 : 430,
    400 : 485,
    450 : 550,
    500 : 600,
    550 : 660,
    600 : 720,
    650 : 780,
    700 : 840,
    750 : 900,
    800 : 960,
    850 : 1020,
    900 : 1080,
    950 : 1140,
    1000: 1200 ]
  
  private let imperialTabulatedTrippingSpeed: [Int : Int] = [
    125  : 175,
    150  : 210,
    175  : 250,
    200  : 280,
    225  : 308,
    250  : 337,
    300  : 395,
    350  : 452,
    400  : 510,
    450  : 568,
    500  : 625,
    600  : 740,
    700  : 855,
    800  : 970,
    900  : 1085,
    1000 : 1200,
    1100 : 1320,
    1200 : 1440,
    1300 : 1560,
    1400 : 1680,
    1500 : 1800,
    1600 : 1920,
    1700 : 2040,
    1800 : 2160,
    1900 : 2280,
    2000 : 2400]
 
  // MARK: - Public Properties
  
  var elevatorRatedSpeed: MyMeasurement = MyMeasurement(of: .speed, value: 0.0, units: UnitSystem.metric)
  var staticControl: Bool = false
  var speedReducingSwitch: Bool = false
  var actualTrippingSpeed: MyMeasurement = MyMeasurement(of: .speed, value: 0.0, units: UnitSystem.metric)
  
  // MARK: - Public Computed Properties
  
  var maximumTrippingSpeed: MyMeasurement {

    if elevatorRatedSpeed.value <= ratedSpeedThresholdForGovernorTripping.lowSpeed.inUnits(elevatorRatedSpeed.unit) {
      return lowGovernorTrippingSpeed(forSpeed: elevatorRatedSpeed)
    }
    
    if elevatorRatedSpeed.value > ratedSpeedThresholdForGovernorTripping.highSpeed.inUnits(elevatorRatedSpeed.unit) {
      return highGovernorTrippingSpeed(forSpeed: elevatorRatedSpeed)
    }
    return tabulatedGovernorTrippingSpeed(forSpeed: elevatorRatedSpeed)
  }
  
  var minimumTrippingSpeed: MyMeasurement {

    return MyMeasurement(of: .speed, value: elevatorRatedSpeed.value * 1.15, units: elevatorRatedSpeed.unit)
  }
  
  var overSpeedSwitchTrippingSpeed: MyMeasurement {
    
    if speedReducingSwitch {
      return(MyMeasurement(of: .speed, value: actualTrippingSpeed.value * 1.0, units: actualTrippingSpeed.unit))
    
    } else if staticControl {
      return(MyMeasurement(of: .speed, value: actualTrippingSpeed.value * 0.9, units: actualTrippingSpeed.unit))
      
    } else if elevatorRatedSpeed.value <= ratedSpeedThresholdForGovernorSwitches.lowSpeed.inUnits(elevatorRatedSpeed.unit) {
      return(MyMeasurement(of: .speed, value: actualTrippingSpeed.value * 1.0, units: actualTrippingSpeed.unit))
    
    } else if elevatorRatedSpeed.value > ratedSpeedThresholdForGovernorSwitches.highSpeed.inUnits(elevatorRatedSpeed.unit) {
      return(MyMeasurement(of: .speed, value: actualTrippingSpeed.value * 0.95, units: actualTrippingSpeed.unit))
      
    } else {
      return(MyMeasurement(of: .speed, value: actualTrippingSpeed.value * 0.9, units: actualTrippingSpeed.unit))
    }
  }
  
  var speedReducingSwitchTrippingSpeed: MyMeasurement {

    if elevatorRatedSpeed.value <= ratedSpeedThresholdForGovernorSwitches.lowSpeed.inUnits(elevatorRatedSpeed.unit) {
      return(MyMeasurement(of: .speed, value: actualTrippingSpeed.value * 1.0, units: actualTrippingSpeed.unit))
      
    } else if elevatorRatedSpeed.value > ratedSpeedThresholdForGovernorSwitches.highSpeed.inUnits(elevatorRatedSpeed.unit) {
      return(MyMeasurement(of: .speed, value: actualTrippingSpeed.value * 0.95, units: actualTrippingSpeed.unit))
      
    } else {
      return(MyMeasurement(of: .speed, value: actualTrippingSpeed.value * 0.9, units: actualTrippingSpeed.unit))
      
    }
  }
  
  // MARK: - Enumeration for speed thresholds
  
  enum ratedSpeedThresholdForGovernorSwitches {
    case lowSpeed, highSpeed
    func inUnits(_ units : UnitSystem) -> Double {
      switch self {
      case .lowSpeed:
        if units == .metric { return 0.75 } else { return 150 }
      case .highSpeed:
        if units == .metric { return 2.5 } else { return 500 }
      }
    }
  }
  
  enum ratedSpeedThresholdForGovernorTripping {
    case lowSpeed, highSpeed
    func inUnits(_ units: UnitSystem) -> Double {
      switch self {
      case .lowSpeed:
        if units == .metric { return 0.63 } else { return 125.0 }
      case .highSpeed:
        if units == . metric { return 10.0 } else { return 2000.0 }
      }
    }
  }
  

  
  // MARK: - Private Methods
  
  // Function to return the maximum governor tripping speed when the rated speed is equal
  // to or below the lowest speed in the table
  
  private func lowGovernorTrippingSpeed(forSpeed ratedSpeed: MyMeasurement) -> MyMeasurement {
    
    let units = ratedSpeed.unit
    
    if units == .metric {
      return MyMeasurement(of: .speed, value: 0.90, units: .metric)
    } else {
      return MyMeasurement(of: .speed, value: 125.0, units: .imperial)
    }
  }
  
  // Function to return the maximum governor tripping speed when the rated speed is above
  // the highest speed in the table
  
  private func highGovernorTrippingSpeed(forSpeed ratedSpeed: MyMeasurement) -> MyMeasurement {
    
    let units = ratedSpeed.unit
    let speed = ratedSpeed.value
    
    if units == .metric {
      return MyMeasurement(of: .speed, value: (speed * 1.20), units: .metric)
    } else {
      return MyMeasurement(of: .speed, value: (speed * 1.20), units: .imperial)
    }
  }
  
  // Function to return the maximum governor tripping speed when the rated speed is in
  // the range of the tablulated values
  
  private func tabulatedGovernorTrippingSpeed(forSpeed ratedSpeed: MyMeasurement) -> MyMeasurement {
    
    let units = ratedSpeed.unit
    let speedKey = ratedSpeed.toGovernorTrippingSpeedKey()
    
    if units == .metric {
      if let tabulatedSpeed = metricTabulatedTrippingSpeed[speedKey] {
        return MyMeasurement(of: .speed, value: Double(tabulatedSpeed)/100.0, units: .metric)
      }
    } else if units == .imperial {
      if let tabulatedSpeed = imperialTabulatedTrippingSpeed[speedKey] {
        return MyMeasurement(of: .speed, value: Double(tabulatedSpeed), units: .imperial)
      }
    }
    
    return interpolatedGovernorTrippingSpeed(forSpeed: ratedSpeed)

  }
  
  // Function to return an interpolated value for the maximum governor tripping speed
  // when the rated speed is in range of the tabulated values
  
  private func interpolatedGovernorTrippingSpeed(forSpeed ratedSpeed: MyMeasurement) -> MyMeasurement {
    
    let units = ratedSpeed.unit
    let speedKey = ratedSpeed.toGovernorTrippingSpeedKey()
    var maxTrippingSpeed: Double!
    var tabulatedTrippingSpeed: [Int : Int]!
    
    if units == .metric {
      tabulatedTrippingSpeed = metricTabulatedTrippingSpeed
    } else {
      tabulatedTrippingSpeed = imperialTabulatedTrippingSpeed
    }
    
    let tabulatedSpeeds = [Int](tabulatedTrippingSpeed.keys).sorted(by: < )
    
    for (i, speed) in tabulatedSpeeds.enumerated() {
      if speed >= speedKey {
        maxTrippingSpeed = (Double(speedKey - tabulatedSpeeds[i - 1]) /
          Double(tabulatedSpeeds[i] - tabulatedSpeeds[i - 1]) *
          Double(tabulatedTrippingSpeed[tabulatedSpeeds[i]]! - tabulatedTrippingSpeed[tabulatedSpeeds[i - 1]]!)) +
          Double(tabulatedTrippingSpeed[tabulatedSpeeds[i - 1]]!)
        break
      }
    }
    
    if units == .metric {
      return(MyMeasurement(of: .speed, value: maxTrippingSpeed/100, units: units))
    } else {
      return(MyMeasurement(of: .speed, value: maxTrippingSpeed/100, units: units))
    }
  }
  
}


  extension MyMeasurement {
    
    func toGovernorTrippingSpeedKey() -> Int {
      if unit == .metric {
        return Int(100 * value)
      } else {
        return Int(value)
      }
    }
  }


