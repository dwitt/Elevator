//
//  UnitSystem.swift
//  Elevator
//
//  Created by David Witt on 2018-04-01.
//  Copyright © 2018 David Witt. All rights reserved.
//

import Foundation

enum UnitSystem: Int {
  case metric = 0
  case imperial = 1
  case unknown = 2
  
  var speed: UnitSpeed {
    get {
      switch self {
      case .metric:
        return UnitSpeed.metersPerSecond
      case .imperial:
        return UnitSpeed.feetPerMinute
      default:
        return UnitSpeed.metersPerSecond
      }
    }
  }
}


