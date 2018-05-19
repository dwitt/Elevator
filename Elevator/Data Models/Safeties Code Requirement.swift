//
//  Safeties Code Requirement.swift
//  Elevator
//
//  Created by David Witt on 2018-04-01.
//  Copyright © 2018 David Witt. All rights reserved.
//

import Foundation

struct SafetiesCodeRequirement {
  
  // MARK: - Private Properties
  
  private enum Distance: Int {
    case minimum = 0
    case maximum = 1
  }
  
  // Declare dictionary to hold an integer array array of tabulated
  // stopping distances. The key is an integer representing the
  // governor tripping speed in either cm/s or f/min.
  
  private var typeBStoppingDistancesForSpeedInCmps = [Int: [Int]]()
  private var typeBStoppingDistancesForSpeedInFpm = [Int : [Int]]()
  
  // MARK: - Public Properties
  
  var maximumGovernorTrippingSpeed: MyMeasurement = MyMeasurement(of: .speed, value: 0.0, units: .metric)
  var governorTrippingSpeed: MyMeasurement = MyMeasurement(of: .speed, value: 0.0, units: .metric)
  var useGovernorTrippingSpeedForStoppingDistance: Bool = true
  
  // MARK: Public Computed Properties
  
  var minimumStoppingDistance: Int {
    if useGovernorTrippingSpeedForStoppingDistance {
      return stopping(distance: .minimum, forSpeed: governorTrippingSpeed)
    } else {
      return stopping(distance: .minimum, forSpeed: maximumGovernorTrippingSpeed)
    }
  }
  
  var maximumStoppingDistance: Int {
    if useGovernorTrippingSpeedForStoppingDistance {
      return stopping(distance: .maximum, forSpeed: governorTrippingSpeed)
    } else {
      return stopping(distance: .maximum, forSpeed: maximumGovernorTrippingSpeed)
    }
  }
  
  // MARK: - Initializer
  
  init?() {
    
    if let stoppingDistances = readStoppingDistances(fromFileNamed: "MetricTypeBSafetyStoppingDistances") {
      typeBStoppingDistancesForSpeedInCmps = stoppingDistances
    } else {
      return nil
    }
    if let stoppingDistances = readStoppingDistances(fromFileNamed: "ImperialTypeBSafetyStoppingDistances") {
      typeBStoppingDistancesForSpeedInFpm = stoppingDistances
    } else {
      return nil
    }
    
  }
  
  // MARK: - Private member functions for Initializer
  
  private func readStoppingDistances(fromFileNamed fileName: String) -> [Int: [Int]]? {
    if let url = getUrlInBundleForFile(withName: fileName, extension: "csv") {
      if let csvString = readCsvFileAsSring(fromURL: url) {
        let stoppingDistances = extractStoppingDistances(fromCsvString: csvString)
        return stoppingDistances
      }
    }
    return nil
  }
  
  private func getUrlInBundleForFile(withName name: String, extension: String)  -> URL? {
    let bundle = Bundle.main
    if let url = bundle.url(forResource: name, withExtension: `extension`) {
        return url
    }
    return nil
  }
  
  private func readCsvFileAsSring(fromURL url: URL) -> String? {
    var csvString : String?
    do {
      csvString = try String(contentsOf: url)
    } catch {
      print (error)
      csvString = nil
    }
    return csvString
  }

  private func extractStoppingDistances(fromCsvString csvString: String) -> [Int: [Int]]? {
    var stoppingDistancesForSpeed = [Int: [Int]]()
    
    let rowsOfCsvStrings: [String] = csvString.components(separatedBy: "\r\n")
    if let numberOfExpectedRowsOfData = integerValueOfFirstRow(fromCsvStringArray: rowsOfCsvStrings) {
      
      if numberOfExpectedRowsOfData == rowsOfCsvStrings.count - 1 && numberOfExpectedRowsOfData != 0 {
        
        rowsOfCsvStrings.forEach { (csvString: String) in
          if csvString.components(separatedBy: ",").count == 3 {
            let columnsOfCsvStrings: [String] = csvString.components(separatedBy: ",")
            let columnsOfInts: [Int] = columnsOfCsvStrings.map { Int($0) ?? 0 }
            stoppingDistancesForSpeed.updateValue([ columnsOfInts[1], columnsOfInts [2]], forKey: columnsOfInts[0])
          }
        }
        if !stoppingDistancesForSpeed.isEmpty {
          return stoppingDistancesForSpeed
        }
      }
    }
    return nil
  }
  
  private func integerValueOfFirstRow(fromCsvStringArray csvArray: [String]) -> Int? {
    if csvArray.isEmpty {
      return nil
    }
    if csvArray[0].components(separatedBy: ",").count != 1 {
      return nil
    }
    return Int(csvArray[0])
  }
  
  // MARK: - Private member functions for computed properties
  
  
  private func tabulatedStoppingDistances(inUnits units: UnitSystem) -> [Int : [Int]] {
    
    switch units {
    case .metric:
      return typeBStoppingDistancesForSpeedInCmps
    case .imperial:
      return typeBStoppingDistancesForSpeedInFpm
    }
  }
  
  private func stopping(distance: Distance, forSpeed speed: MyMeasurement) -> Int {
    
    let units = speed.units
    let speedKey = speed.valueToSpeedKey()
    
    if speedKey <= speedThresholdForTypeBSafetyStoppingDistance.low.inUnits(units) {
      return lowSpeedSlide(distance: distance, forSpeed: speed)
      
    } else if speedKey > speedThresholdForTypeBSafetyStoppingDistance.high.inUnits(units) {
      return calculatedSlide(distance: distance, forSpeed: speed)
      
    } else {
      return tabulatedSlide(distance: distance, forSpeed: speed)
    }
    
  }
  
  private func lowSpeedSlide(distance: Distance, forSpeed speed: MyMeasurement) -> Int {
    
    switch distance {
    case .minimum:
      return lowSpeedMinimumPermittedSlide(forSpeed: speed)
    case .maximum:
      return lowSpeedMaximumPermittedSlide(forSpeed: speed)
    }
  }
  
  private func lowSpeedMaximumPermittedSlide(forSpeed speed: MyMeasurement) -> Int {
    
    switch speed.units {
    case .metric:
      return 380
    case .imperial:
      return 15
    }
  }
  
  private func lowSpeedMinimumPermittedSlide(forSpeed speed: MyMeasurement) -> Int {
    
    switch speed.units {
    case .metric:
      return 25
    case .imperial:
      return 1
    }
  }
  
  private func calculatedSlide(distance: Distance, forSpeed speed: MyMeasurement) -> Int {
    
    switch distance {
    case .minimum:
      return calculateMinimumPermittedSlide(forSpeed: speed)
    case .maximum:
      return calculateMaximumPermittedSlide(forSpeed: speed)
    }
  }
  
  private func calculateMaximumPermittedSlide(forSpeed speed: MyMeasurement) -> Int {
    
    switch speed.units {
    case .metric:
      return Int((pow(speed.value,2.0) / 6.870 + 0.256) * 1000.0)
    case .imperial:
      return Int((pow(speed.value,2.0) / 81144.0 + 0.84) * 12.0)
    }
  }
  
  private func calculateMinimumPermittedSlide(forSpeed speed: MyMeasurement) -> Int{
    
    switch speed.units {
    case .metric:
      return Int((pow(speed.value,2.0) / 19.63) * 1000.0)
    case .imperial:
      return Int((pow(speed.value,2.0) / 231840.0) * 12.0)
    }
  }
  
  private func tabulatedSlide(distance: Distance, forSpeed speed: MyMeasurement) -> Int {
   
    let speedKey = speed.valueToSpeedKey()
    let units = speed.units
    
    let tabulatedStoppingDistancesForSpeed = tabulatedStoppingDistances(inUnits: units)
    
    if let stoppingDistances = tabulatedStoppingDistancesForSpeed[speedKey] {
      return stoppingDistances[distance.rawValue]
    }
    
    return interpolatedSlide(distance: distance, forSpeed: speed)
  }

  
  private func interpolatedSlide(distance: Distance, forSpeed speed: MyMeasurement) -> Int {
    
    var slideDistance: Int = 0
    let speedKey = speed.valueToSpeedKey()
    let units = speed.units
    let tabulatedStoppingDistanceForSpeed = tabulatedStoppingDistances(inUnits: units)
  
    let tabulatedSpeeds = Array(tabulatedStoppingDistanceForSpeed.keys).sorted(by: < )
    
    for (i, speed) in tabulatedSpeeds.enumerated() {
      
      if speed >= speedKey {
        
        let speedKeyFractionOfTabulatedSpeedKeys = Double(speedKey - tabulatedSpeeds[i - 1]) / Double(tabulatedSpeeds[i] - tabulatedSpeeds[i-1])
        
        let differenceBetweenTabulatedStoppingDistances = (tabulatedStoppingDistanceForSpeed[tabulatedSpeeds[i]]![distance.rawValue] - tabulatedStoppingDistanceForSpeed[tabulatedSpeeds[i - 1]]![distance.rawValue])
        
        let lowerTabulatedStoppingDistance = (tabulatedStoppingDistanceForSpeed[tabulatedSpeeds[i - 1]]![distance.rawValue])
        
        slideDistance = Int(speedKeyFractionOfTabulatedSpeedKeys * Double(differenceBetweenTabulatedStoppingDistances)) + lowerTabulatedStoppingDistance
        

        break
      }
      
    }
    
    return slideDistance
  
  }
  
  enum speedThresholdForTypeBSafetyStoppingDistance {
    case low, high
    func inUnits(_ units: UnitSystem) -> Int {
      switch self {
      case .low:
        if units == .metric { return 90 } else { return 175 }
      case .high:
        if units == .metric { return 1200 } else { return 2400 }
      }
    }
  }
  
}

extension MyMeasurement {
  
  func valueToSpeedKey() -> Int {
    if units == .metric {
      return Int(100 * value)
    } else {
      return Int(value)
    }
  }
}
