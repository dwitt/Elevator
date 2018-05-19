//
//  Dimension.swift
//  Elevator
//
//  Created by David Witt on 2018-05-17.
//  Copyright © 2018 David Witt. All rights reserved.
//

import Foundation

extension UnitSpeed {
  static let feetPerMinute =  UnitSpeed(symbol: "fpm", converter: UnitConverterLinear(coefficient: 304.8/60000.0))
}
