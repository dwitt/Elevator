//
//  governorTableViewController.swift
//
//  Created by David Witt on 2018-01-25.
//  Copyright © 2018 David Witt. All rights reserved.
//

import UIKit
import Foundation

class governorTableViewController: UITableViewController {
  
  // MARK: - Properties
  
  // The governorInspectionViewModel will be created by dependency injection
  var viewModel: GovernorInspectionViewModel?
  
  var textFieldDelegateForDecimalInput = TextFieldDelegateForDecimalInput()
  
  @IBOutlet weak var ratedSpeedLabel: UILabel!
  @IBOutlet weak var maxGovernorTrippingSpeedLabel: UILabel!
  @IBOutlet weak var ratedSpeedUnitsSegmentControl: UISegmentedControl!

  @IBOutlet weak var ratedSpeedForGovernorLabel: UILabel!
  @IBOutlet weak var ratedSpeedUnitsForGovernorSegmentControl: UISegmentedControl!
  @IBOutlet weak var mGTSL: UILabel!

  @IBOutlet weak var TabulatedEquivalentSpeeds: UISwitch!
  @IBOutlet weak var maxGovernorTrippingSpeedUnitsSegmentControl: UISegmentedControl!
  
  @IBOutlet weak var actualGovernorTrippingSpeedTextField: UITextField!
  @IBOutlet weak var actualGovernorTrippingSpeedUnitsSegmentControl: UISegmentedControl!
  
  
  @IBOutlet weak var overspeedSwitchSpeedUnitsSegmentControl: UISegmentedControl!
  @IBOutlet weak var overspeedSwitchSpeedLabel: UILabel!
  @IBOutlet weak var speedReducingSwitchSpeedUnitsSegmentControl: UISegmentedControl!
  @IBOutlet weak var speedReducingSwitchSpeedLabel: UILabel!

  
  @IBOutlet weak var staticControlSwitch: UISwitch!
  @IBOutlet weak var speedReducingSwitch: UISwitch!
  
  @IBOutlet weak var minGovernorTrippingSpeedLabel: UILabel!
  @IBOutlet weak var minGovernorTrippingSpeedUnitsSegmentControl: UISegmentedControl!
  
  // MARK: - Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // Set the delegate of the ratedSpeedTextField so that we can detect return and dismiss the keyboard when required
    
    actualGovernorTrippingSpeedTextField.delegate = textFieldDelegateForDecimalInput
    
    // Setup Keyboard for tripping speed text input
    let toolBar = createToolBarForDecimalPadWithDoneButtonWith(action: #selector(doneBarButtonPressed(sender:)))
    
    addInputAccessoryView(toolBar, to: actualGovernorTrippingSpeedTextField)
    
    
    updateView()
    
  }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (mGTSL.frame.size.width < 200 ) {
            mGTSL.text = "Max. Tripping Spd"
        } else {
            mGTSL.text = "Max. Tripping Speed"
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  private func createToolBarForDecimalPadWithDoneButtonWith(action: Selector?) -> UIToolbar {
    
    let toolBar = UIToolbar()
    
    let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: action)
    
    toolBar.sizeToFit()
    toolBar.items = [space, doneBarButtonItem]
    
    return toolBar
  }
  
  private func addInputAccessoryView(_ accessoryView: UIToolbar, to textField: UITextField) {
    textField.inputAccessoryView = accessoryView
  }
  
  @objc func doneBarButtonPressed(sender: UIControl) {
    // Check which text field is editing and resign the first responder
    
   if actualGovernorTrippingSpeedTextField.isEditing {
    actualGovernorTrippingSpeedTextField.resignFirstResponder()
    }
    
  }
  
  private func updateView() {
    if let viewModel = viewModel {
      updateGovernorInspectionViewWith(viewModel: viewModel)
    }
  }
  
  private func updateGovernorInspectionViewWith(viewModel: GovernorInspectionViewModel) {
    
    ratedSpeedLabel.text = viewModel.elevatorRatedSpeed.valueAsString
    ratedSpeedUnitsSegmentControl.selectedSegmentIndex = viewModel.elevatorRatedSpeed.unitSystem.rawValue
    
    ratedSpeedForGovernorLabel.text = viewModel.elevatorRatedSpeedForGovernorSetting.valueAsString
    ratedSpeedUnitsForGovernorSegmentControl.selectedSegmentIndex = viewModel.elevatorRatedSpeedForGovernorSetting.unitSystem.rawValue
    
    TabulatedEquivalentSpeeds.isOn = viewModel.tabulatedEquivalentSpeeds
    
    actualGovernorTrippingSpeedTextField.text = viewModel.governorTrippingSpeed.valueAsString
    actualGovernorTrippingSpeedUnitsSegmentControl.selectedSegmentIndex = viewModel.governorTrippingSpeed.unitSystem.rawValue
    
    staticControlSwitch.isOn = viewModel.staticControl
    
    speedReducingSwitch.isOn = viewModel.speedReducingSwitch
    
    maxGovernorTrippingSpeedLabel.text = viewModel.governorMaximumTrippingSpeed.valueAsString
    maxGovernorTrippingSpeedUnitsSegmentControl.selectedSegmentIndex = viewModel.governorMaximumTrippingSpeed.unitSystem.rawValue
    
    minGovernorTrippingSpeedLabel.text = viewModel.governorMinimumTrippingSpeed.valueAsString
    minGovernorTrippingSpeedUnitsSegmentControl.selectedSegmentIndex = viewModel.governorMinimumTrippingSpeed.unitSystem.rawValue
    
    overspeedSwitchSpeedLabel.text = viewModel.governorOverspeedSwitchMaximumTrippingSpeed.valueAsString
    overspeedSwitchSpeedUnitsSegmentControl.selectedSegmentIndex = viewModel.governorOverspeedSwitchMaximumTrippingSpeed.unitSystem.rawValue
    
    speedReducingSwitchSpeedLabel.text = viewModel.governorSpeedReducingSwitchMaximumTrippingSpeed.valueAsStringWhen(conditionIsFalse: speedReducingSwitch.isOn)
    speedReducingSwitchSpeedUnitsSegmentControl.selectedSegmentIndex = viewModel.governorSpeedReducingSwitchMaximumTrippingSpeed.unitSystem.rawValue
    
  }
  
  @objc func doneBarButtonPressed() {
    // Check which text field is editing and resign the first responder
    
    if actualGovernorTrippingSpeedTextField.isEditing {
      actualGovernorTrippingSpeedTextField.resignFirstResponder()
    }
    
  }
  
  private func saveGovernorTrippingSpeedText() {
    
    if actualGovernorTrippingSpeedTextField.isEditing, let trippingSpeedText = actualGovernorTrippingSpeedTextField.text {
      if let newTrippingSpeed = Double(trippingSpeedText), let currentTrippingSpeed = viewModel?.governorTrippingSpeed.value {
        if newTrippingSpeed != currentTrippingSpeed {
          viewModel?.governorTrippingSpeed.valueAsString = trippingSpeedText
        }
      }
    }
  }

  
  //MARK: - Recieve Messages from View
  
  @IBAction func ratedSpeedForGovernorUnitsChanged() {
    // called when the units for the rated speed for governor units changes

    saveGovernorTrippingSpeedText()
    
    if let unit = UnitSystem(rawValue: ratedSpeedUnitsForGovernorSegmentControl.selectedSegmentIndex)?.speed {
      viewModel?.elevatorRatedSpeedForGovernorSetting.convert(to: unit)
    }
    updateView()
  }
  
  @IBAction func tabulatedEquivalentChanged() {
    saveGovernorTrippingSpeedText()
    viewModel?.tabulatedEquivalentSpeeds = TabulatedEquivalentSpeeds.isOn
    updateView()
  }
  
  @IBAction func actualGovernorTrippingSpeedChanged() {
    if let trippingSpeedText = actualGovernorTrippingSpeedTextField.text {
      viewModel?.governorTrippingSpeed.valueAsString = trippingSpeedText
      updateView()
    }
  }
  
  // User changes the speed units segment control
  

  // We have two options
  // If we are currently editing the speed value then the units change
  //    should not affect the value as we are setting a value and units simultaneously
  // If we are not currently editing the speed value then we need to peforma conversion
  
  @IBAction func actualGovernorTrippingSpeedUnitsChanged() {
    if actualGovernorTrippingSpeedTextField.isEditing {     
      // TODO: - Fix the forced unwarp !!!
      if let selectedUnitSystem = UnitSystem(rawValue : actualGovernorTrippingSpeedUnitsSegmentControl.selectedSegmentIndex) {
        viewModel?.governorTrippingSpeed = Measurement(value: actualGovernorTrippingSpeedTextField.text, unitSystem: selectedUnitSystem)
        updateView()
      }
    } else {
      viewModel?.governorTrippingSpeed.convert(to: UnitSystem(rawValue: actualGovernorTrippingSpeedUnitsSegmentControl.selectedSegmentIndex)!)
      updateView()
    }
    
    
    //viewModel?.governorTrippingSpeed.unitsAsInt = actualGovernorTrippingSpeedUnitsSegmentControl.selectedSegmentIndex
    //if !actualGovernorTrippingSpeedTextField.isEditing {
    //  updateView()
    //}
  }
  
  @IBAction func staticControlSwitchChanged() {
    saveGovernorTrippingSpeedText()
    viewModel?.staticControl = staticControlSwitch.isOn
    updateView()
  }
  
  @IBAction func speedReducingSwitchChanged() {
    saveGovernorTrippingSpeedText()
    viewModel?.speedReducingSwitch = speedReducingSwitch.isOn
    updateView()
  }
  
  @IBAction func maxGovernorTrippingSpeedUnitsChanged() {
    saveGovernorTrippingSpeedText()
    if let unit = UnitSystem(rawValue: maxGovernorTrippingSpeedUnitsSegmentControl.selectedSegmentIndex)?.speed {
      viewModel?.governorMaximumTrippingSpeed.convert(to: unit)
    }
    updateView()
  }
  
  @IBAction func minGovernorTrippingSpeedUnitsChanged() {
    saveGovernorTrippingSpeedText()
    if let unit = UnitSystem(rawValue: minGovernorTrippingSpeedUnitsSegmentControl.selectedSegmentIndex)?.speed {
      viewModel?.governorMinimumTrippingSpeed.convert(to: unit)
    }
    updateView()
  }
  
  @IBAction func overspeedSwitchSpeedUnitsChanged() {
    saveGovernorTrippingSpeedText()
    if let unit = UnitSystem(rawValue: overspeedSwitchSpeedUnitsSegmentControl.selectedSegmentIndex)?.speed {
      viewModel?.governorOverspeedSwitchMaximumTrippingSpeed.convert(to: unit)
    }
    updateView()
  }
  
  @IBAction func speedReducingSwitchSpeedUnitsChanged() {
    saveGovernorTrippingSpeedText()
    if let unit = UnitSystem(rawValue: speedReducingSwitchSpeedUnitsSegmentControl.selectedSegmentIndex)?.speed {
      viewModel?.governorSpeedReducingSwitchMaximumTrippingSpeed.convert(to: unit)
    }
    
    updateView()
  }
  
  
  
  private func createToolBarWithDoneButtonForDecimalPad() -> UIToolbar {
    
    let toolBar = UIToolbar()
    
    let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBarButtonPressed(sender:)))
    
    toolBar.sizeToFit()
    toolBar.items = [space, doneBarButtonItem]
    
    return toolBar
    
    
  }
  
  private func addInputAccessoryViewTo(_ accessoryView: UIToolbar, to textField: UITextField) {
    textField.inputAccessoryView = accessoryView
  }
  
  
}

// Setup this view controller as a UITextField Delegate
// This view controller can now handle some of the messages from the text fields
extension governorTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // See which text field received the return
        if textField == actualGovernorTrippingSpeedTextField{
            // stop displaying the keyboard
            textField.resignFirstResponder()
            return false
        }
        
      
    return true
    }
}



extension governorTableViewController: UITextViewDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField != actualGovernorTrippingSpeedTextField { return true } // accept the characters if not in a text field we need
        
        let decimalSeparator: String
        let locale = Locale.current
        if let decimal = locale.decimalSeparator {
            decimalSeparator = decimal
        } else {
            decimalSeparator = "." // use decimal if not specified
        }
        
        if string.count <= 1 {
            // we have a single character
            switch string {
            case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
                return true
            case decimalSeparator:
                // if the character is a decimal make sure we don't already have one
                if let text = textField.text {
                    if text.components(separatedBy: decimalSeparator).count > 1 {
                        // At lest two components seperated by a decimal
                        return false
                    } else {
                        return true
                    }
                } else {
                    return true
                }
            default:
                let array = Array(string)
                if array.count == 0 {
                    return true
                } else {
                    return false
                }
            }
        } else {
            // we have more than one character and are likely pasting in some text
            
            // temp return false
            return false
        }
    }
  
  
}

extension Measurement where UnitType: UnitSpeed {
  func valueAsStringWhen(conditionIsFalse : Bool) -> String {
    if !conditionIsFalse {
      return ( "---" )
    } else {
      return valueAsString
    }
  }
  
}
