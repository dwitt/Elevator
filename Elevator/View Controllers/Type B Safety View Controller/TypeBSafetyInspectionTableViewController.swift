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
  @IBAction func helpUIBarButtonItem(_ sender: UIBarButtonItem) {
  }
}
