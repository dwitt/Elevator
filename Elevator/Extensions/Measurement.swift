//
//  Measurement.swift
//  Elevator
//
//  Created by David Witt on 2018-05-20.
//  Copyright © 2018 David Witt. All rights reserved.
//

import Foundation

extension Measurement where UnitType: UnitSpeed {
  func convertToMyMeasurement() -> MyMeasurement {
    
    var myMeasurement = MyMeasurement(of: .speed, value: self.value, units: self.unit.unitSystem)
    return myMeasurement
  }
}
