//
//  UnitSpeed.swift
//  Elevator
//
//  Created by David Witt on 2018-05-17.
//  Copyright © 2018 David Witt. All rights reserved.
//

import Foundation

extension UnitSpeed {
  static let feetPerMinute =  UnitSpeed(symbol: "fpm", converter: UnitConverterLinear(coefficient: 304.8/60000.0))
}

// TODO: - Extension only required while refactoring for Foundation Measurement Class

extension UnitSpeed {
  var unitSystem: UnitSystem {
    get {
      var system: UnitSystem
      
      switch self.symbol {
      case "m/s":
        system = UnitSystem.metric
      case "fpm":
        system = UnitSystem.imperial
      default:
        system = UnitSystem.metric
      }
      return system
    }
  }
}
