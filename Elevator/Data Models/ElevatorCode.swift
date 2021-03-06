//
//  ElevatorCode.swift
//  Elevator
//
//  Created by David Witt on 2018-02-09.
//  Copyright © 2018 David Witt. All rights reserved.
//

import Foundation

struct ElevatorCode {

    
  var governor: GovernorCodeRequirement = GovernorCodeRequirement()
  var safeties: SafetiesCodeRequirement
  
  init() {
    do {
      try self.safeties = SafetiesCodeRequirement()
    }
    catch {
      fatalError()
    }
  }
  
}
