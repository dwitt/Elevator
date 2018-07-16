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
    governorTrippingSpeedSegmentedControl.selectedSegmentIndex = viewModel.governorTrippingSpeedUnits
    
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
  
  @IBAction func longPressGesture(_ sender: UILongPressGestureRecognizer) {
    guard sender.view != nil else {return}
    
    if sender.state == .began {
      self.becomeFirstResponder()
      
      let title: String
      let message: String
      
      if let indexPath = tableView.indexPathForRow(at: sender.location(in: tableView)) {
        let row = indexPath.row
        let section = indexPath.section
        
        switch section {
        case 0:
          switch row {
          case 0:
            title = "Rated Speed"
            message = "The elevator rated speed is the rated speed or contract speed of the elevator."
          case 1:
            title = "EGovernor Tripping Speed"
            message = "The actual governor tripping speed measured during testing. It can be entered either on the main screen or on the governor inspection screen."
          default:
            title = "No Help Available"
            message = ""
            break
          }
        case 1:
          switch row {
          case 0:
            title = "Governor Inspection"
            message = "Use this selection when inspecting the governor. It will provide the maximum and minimum governor tripping speeds as well as the overspeed and speed redcuing switch settings."
          case 1:
            title = "Type B Safety Inspection"
            message = "Use this selection when inspecting Type B Safeties. This selection should be used after verifying the governor tripping speed. It will provide the maximum and minimum safety slide distances."
          default :
            title = "No Help Available"
            message = ""
          }
        default:
          title = "No Help Available"
          message = ""
          break
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
    }
  
  }
  
  
  
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    
    if textFieldDelegateForDecimalInput.activeTextField.isEditing {
      textFieldDelegateForDecimalInput.activeTextField.resignFirstResponder()
    }
    
    if let identifier = segue.identifier {
      switch identifier {
      case "governorInspection":
        prepareGovernorTableViewController(for: segue)
      case "typeBSafetyInspection":
        prepareTypeBSafetyInspectionTableViewController(for: segue)
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
  
  func prepareTypeBSafetyInspectionTableViewController(for segue: UIStoryboardSegue) {
    let typeBSafetyInspectionTableViewController = segue.destination as! TypeBSafetyInspectionTableViewController
    
    if let viewModel = viewModel {
      typeBSafetyInspectionTableViewController.viewModel = viewModel.createTypeBSafetyInspectionViewModel()
    }
  }
  
}



