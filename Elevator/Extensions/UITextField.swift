//
//  UITextField.swift
//  Elevator
//
//  Created by David Witt on 2018-03-20.
//  Copyright © 2018 David Witt. All rights reserved.
//

import UIKit

extension UITextField {
  
  func doesNotContain(_ character: Character) -> Bool {
    
    if let text = self.text {
      if text.contains(character) {
        return false
      } else {
        return true
      }
    } else {
      return true
    }
    
  }
}
