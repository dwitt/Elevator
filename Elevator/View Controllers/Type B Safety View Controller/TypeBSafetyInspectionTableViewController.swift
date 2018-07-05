//
//  TypeBSafetyInspectionTableViewController.swift
//  Elevator
//
//  Created by David Witt on 2018-05-02.
//  Copyright © 2018 David Witt. All rights reserved.
//

import UIKit

class TypeBSafetyInspectionTableViewController: UITableViewController {
  
  // MARK: - Properties
  
  var viewModel: TypeBSafetyInspectionViewModel?
  
  // MARK: elevator properties
  
  @IBOutlet weak var ratedSpeedLabel: UILabel!
  @IBOutlet weak var ratedSpeedUnitsSegmentControl: UISegmentedControl!
  @IBOutlet weak var governorTrippingSpeedLabel: UILabel!
  @IBOutlet weak var governorTrippingSpeedUnitsSegmentControl: UISegmentedControl!
  
  // MARK: type B safety properties
  
  @IBOutlet weak var ratedSpeedForSafetySlideLabel: UILabel!
  @IBOutlet weak var ratedSpeedUnitsForSafetySlideSegmentControl: UISegmentedControl!
  @IBOutlet weak var tabulatedEquivalentSpeedsSwitch: UISwitch!
  @IBOutlet weak var maximumGovernorTrippingSpeedLabel: UITextField!
  @IBOutlet weak var maximumGovernorTrippingSpeedUnitsSegmentControl: UISegmentedControl!
  @IBOutlet weak var safetySlideSpeedSelectionSegmentControl: UISegmentedControl!
  
  @IBOutlet weak var actualGovernorTrippingSpeedCell: UITableViewCell!
  @IBOutlet weak var maximumGovernorTrippingSpeedCell: UITableViewCell!
  
  // MARK: code properties
  
  @IBOutlet weak var maximumSlideLabel: UILabel!
  @IBOutlet weak var maximumSlideUnitsSegmentControl: UISegmentedControl!
  @IBOutlet weak var minimumSlideLabel: UILabel!
  @IBOutlet weak var minimumSlideUnitsSegmentControl: UISegmentedControl!
  
  // MARK: - Methods
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    

    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
    
    updateView()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  // MARK: - Private Methods
  
  private func updateView() {
    
    if let viewModel = viewModel {
      updateTypeBSafetyInspectionTableViewController(with: viewModel)
    }
  }

  private func updateTypeBSafetyInspectionTableViewController(with viewModel: TypeBSafetyInspectionViewModel) {
    
    ratedSpeedLabel.text = viewModel.elevatorRatedSpeed.valueAsString
    ratedSpeedUnitsSegmentControl.selectedSegmentIndex = viewModel.elevatorRatedSpeed.unitSystem.rawValue
    
    governorTrippingSpeedLabel.text = viewModel.governorTrippingSpeed.valueAsString
    governorTrippingSpeedUnitsSegmentControl.selectedSegmentIndex = viewModel.governorTrippingSpeed.unitSystem.rawValue
    
    ratedSpeedForSafetySlideLabel.text = viewModel.ratedSpeedForSafetySlide.valueAsString
    ratedSpeedUnitsForSafetySlideSegmentControl.selectedSegmentIndex = viewModel.ratedSpeedForSafetySlide.unitSystem.rawValue
    
    maximumGovernorTrippingSpeedLabel.text = viewModel.maximumGovernorTrippingSpeed.valueAsString
    maximumGovernorTrippingSpeedUnitsSegmentControl.selectedSegmentIndex = viewModel.maximumGovernorTrippingSpeed.unitSystem.rawValue
    
    maximumSlideLabel.text = viewModel.maximumSafetySlide.valueAsString
    maximumSlideUnitsSegmentControl.selectedSegmentIndex = viewModel.maximumSafetySlide.unitSystem.rawValue
    
    minimumSlideLabel.text = viewModel.minimumSafetySlide.valueAsString
    minimumSlideUnitsSegmentControl.selectedSegmentIndex = viewModel.minimumSafetySlide.unitSystem.rawValue
    
    switch safetySlideSpeedSelectionSegmentControl.selectedSegmentIndex {
    case 0:
      actualGovernorTrippingSpeedCell.contentView.backgroundColor = UIColor(red:1.0, green: 0, blue: 0, alpha: 0.03)
      maximumGovernorTrippingSpeedCell.contentView.backgroundColor = nil
    case 1:
      actualGovernorTrippingSpeedCell.contentView.backgroundColor = nil
      maximumGovernorTrippingSpeedCell.contentView.backgroundColor = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.03)
    default:
      break

    }
  }
  
  // MARK: - Recieve messages from view
  
  @IBAction func ratedSpeedUnitsSegmentedControlValueChanged() {
    
    if let unitSystem = UnitSystem(rawValue: ratedSpeedUnitsForSafetySlideSegmentControl.selectedSegmentIndex) {
      viewModel?.ratedSpeedForSafetySlide.convert(to: unitSystem)
    }
    updateView()
  }
  
  @IBAction func tabulatedEquivalentSpeedsSwitchValueChanged() {
    viewModel?.tabulatedEquivalentSpeeds = tabulatedEquivalentSpeedsSwitch.isOn
    updateView()
  }
  
  @IBAction func maximumGovernorTrippingSpeedSegmentedControlChanged() {
    if let unitSystem = UnitSystem(rawValue: maximumGovernorTrippingSpeedUnitsSegmentControl.selectedSegmentIndex) {
      viewModel?.maximumGovernorTrippingSpeed.convert(to: unitSystem)
      updateView()
    }
  }
  @IBAction func actualOrMaxGovernorTrippingSpeedSegmentedControlChanged() {
    switch safetySlideSpeedSelectionSegmentControl.selectedSegmentIndex {
    case 0:
      viewModel?.slideCalulationBasedOnMaximumGovernorTrippingSpeed = false

    case 1:
      viewModel?.slideCalulationBasedOnMaximumGovernorTrippingSpeed = true

      
    default:
      viewModel?.slideCalulationBasedOnMaximumGovernorTrippingSpeed = false
    }
    updateView()
  }
  @IBAction func maximumSlideUnitsSegmentedControlChanged() {
    if let unitSystem = UnitSystem(rawValue: maximumSlideUnitsSegmentControl.selectedSegmentIndex) {
      viewModel?.maximumSafetySlide.convert(to: unitSystem)
    }
    updateView()
  }
  @IBAction func minimumSlideUnitsSegmentedControlChanged() {
    if let unitSystem = UnitSystem(rawValue: minimumSlideUnitsSegmentControl.selectedSegmentIndex) {
      viewModel?.minimumSafetySlide.convert(to: unitSystem)
    }
    updateView()
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
            title = "Elevator Data - Rated Speed"
            message = "The elevator rated speed is the rated speed or contract speed of the elevator. It can only be changed by going back to the previous screen."
          case 1:
            title = "Elevator Data - Governor Tripping Speed"
            message = "The actual governor tripping speed entered either on the main screen or on the governor inspection screen. It can only be changed by going back to one of these screens"
          default:
            title = "No Help Available"
            message = ""
            break
          }
        case 1:
          switch row {
          case 0:
            title = "Type B Safety Data - Rated Speed"
            message = "The elevator rated speed that will be used to determine the minimum and maximum allowable safety slide distances. When changing units, the position of the 'Tabulated/Equivalent Speeds' switch will be used to determine how the speed units will be converted. "
          case 1:
            title = "Tabulated/Equivalent Speeds"
            message = "When in the ON position, changing the units of 'Rated Speed' will be performed by using the tables from the A17.1/B44 code book. If the speed before conversion is found in the maximum and minimum stoping distances speed table an equivalent speed will be selected from the table for the new units system. The ON performs what is sometimes called 'soft conversions'."
          case 2:
            title = "Max. Tripping Speed"
            message = "This is the maximum governor tripping speed permitted for rated speed above. This value may be different from the actual tripping speed setting."
          case 3:
            title = "Slide per Governor Tripping Speed"
            message = "This selection determines the basis for the maximum and minimum slide distances. If 'Actual' is selected the slide distance will be based on the actual governor tripping speed. If 'Max.' is selected the maximum permitted governor tripping speed will be used based on the Type B Safety Data - Rated Speed. The speed value used will have its background shaded to identify which speed is being using."
          default:
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
  
}
