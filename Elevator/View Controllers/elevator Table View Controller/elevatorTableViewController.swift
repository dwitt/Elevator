//
//  elevatorTableViewController.swift
//  Elevator
//
//  Created by David Witt on 2018-03-05.
//  Copyright © 2018 David Witt. All rights reserved.
//

import UIKit


class elevatorTableViewController: UITableViewController{
  
  @IBOutlet weak var ratedSpeedTextField: UITextField!
  @IBOutlet weak var ratedSpeedUnitsSegmentedControl: UISegmentedControl!
  @IBOutlet weak var governorTrippingSpeedTextField: UITextField!
  @IBOutlet weak var governorTrippingSpeedSegmentedControl: UISegmentedControl!
  
  // ViewModel to be created by Dependency Injection
  // ViewController owns the ViewModel
  
  var viewModel: ElevatorViewModel?
  let textFieldDelegateForDecimalInput: TextFieldDelegateForDecimalInput = TextFieldDelegateForDecimalInput()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateView()
    
    let toolBar = createToolBarWithDoneButtonForDecimalPad()
    addInputAccessoryViewTo(toolBar, to: ratedSpeedTextField)
    addInputAccessoryViewTo(toolBar, to: governorTrippingSpeedTextField)
    
    
    ratedSpeedTextField.delegate = textFieldDelegateForDecimalInput
    governorTrippingSpeedTextField.delegate = textFieldDelegateForDecimalInput
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  override func viewWillAppear(_ animated: Bool) {
    updateView()
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - DONE Button methods
  
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

  @objc func doneBarButtonPressed(sender: UIControl) {
    
    if textFieldDelegateForDecimalInput.activeTextField.isEditing {
      textFieldDelegateForDecimalInput.activeTextField.resignFirstResponder()
    }
    
  }
  
  // MARK: -
  
  private func updateView() {
    
    if let viewModel = viewModel {
      updateElevatorView(withViewModel: viewModel)
    }
  }
  
  private func updateElevatorView(withViewModel viewModel: ElevatorViewModel) {
    
    ratedSpeedTextField.text = viewModel.ratedSpeed
    ratedSpeedUnitsSegmentedControl.selectedSegmentIndex = viewModel.ratedSpeedUnits
    
    governorTrippingSpeedTextField.text = viewModel.governorTrippingSpeed
    governorTrippingSpeedSegmentedControl.selectedSegmentIndex = viewModel.ratedSpeedUnits
    
  }
  
  @IBAction func ratedSpeedTextFieldEditingDidEnd() {
    if viewModel != nil  {
      if let text = ratedSpeedTextField.text {
        viewModel?.ratedSpeed = text
      }
    }
  }
  
  @IBAction func ratedSpeedSegmentedControlValueChanged() {
    if viewModel != nil {
      viewModel?.ratedSpeedUnits = ratedSpeedUnitsSegmentedControl.selectedSegmentIndex
      if ratedSpeedTextField.isFirstResponder {
        return
      } else {
        ratedSpeedTextField.text = viewModel?.ratedSpeed
      }
    }
  }
  
  @IBAction func governorTrippingSpeedFieldEditingDidEnd() {
    if viewModel != nil {
      if let text = governorTrippingSpeedTextField.text {
        viewModel?.governorTrippingSpeed = text
      }
    }
  }
  
  @IBAction func governorTrippingSpeedSegmentedControlValueChanged() {
    if viewModel != nil {
      viewModel?.governorTrippingSpeedUnits = governorTrippingSpeedSegmentedControl.selectedSegmentIndex
      if governorTrippingSpeedTextField.isFirstResponder {
        return
      } else {
        governorTrippingSpeedTextField.text = viewModel?.governorTrippingSpeed
      }
    }
  }
  
  
  
  
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    
    if let identifier = segue.identifier {
      switch identifier {
      case "governorInspection":
        prepareGovernorTableViewController(for: segue)
      default:
        return
      }
    }
    
  }
  
  func prepareGovernorTableViewController(for segue: UIStoryboardSegue ) {
    let governorTableViewController = segue.destination as! governorTableViewController
    
    // inject the dependancy
    if let viewModel = viewModel {
      governorTableViewController.viewModel = viewModel.createGovernorInspectionViewModel()
    }
  }
  
}



