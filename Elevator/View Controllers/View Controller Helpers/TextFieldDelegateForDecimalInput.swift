   //
//  UITextFieldDelegate.swift
//  Elevator
//
//  Created by David Witt on 2018-03-21.
//  Copyright © 2018 David Witt. All rights reserved.
//

import UIKit

class TextFieldDelegateForDecimalInput: NSObject, UITextFieldDelegate {
  
  
  var activeTextField = UITextField()
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    self.activeTextField = textField
  }
  
  
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    return true
  }

  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    if string.count <= 1 {
      
      return textFieldForPositiveDecimalNumber(textField, shouldAcceptNewCharacter: string)
    } else {
      
      // we have more than one character and are likely pasting in some text
      // temp return false
      return false
    }
  }
  
  private func textFieldForPositiveDecimalNumber(_ textField: UITextField, shouldAcceptNewCharacter string: String) -> Bool {
    
    let decimalSeparator = getDecimalSeparator()
    
    switch string {
      
    case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
      return true
      
    case decimalSeparator:
      return textField.doesNotContain(Character(decimalSeparator))
      
    default:
      return string.containsOnlyWhiteSpace
    }
  }
  
  
  private func getDecimalSeparator() -> String {
    
    let locale = Locale.current
    
    if let decimal = locale.decimalSeparator {
      return decimal
    } else {
      return "."
    }
  }
}


