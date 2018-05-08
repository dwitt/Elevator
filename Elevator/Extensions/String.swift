//
//  String.swift
//  Elevator
//
//  Created by David Witt on 2018-03-20.
//  Copyright © 2018 David Witt. All rights reserved.
//

import Foundation

extension String {
  
  var containsOnlyWhiteSpace: Bool {
    get {
      let array = Array(self)
      if array.count == 0 {
        return true
      } else {
        return false
      }
    }
    }
}
