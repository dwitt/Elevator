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
  
  // MARK: code properties
  
  @IBOutlet weak var maximumSlideLabel: UILabel!
  @IBOutlet weak var maximumSlideUnitsSegmentControl: UISegmentedControl!
  @IBOutlet weak var minimumSlideLabel: UILabel!
  @IBOutlet weak var minimumSlideUnitsSegmentControl: UISegmentedControl!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

}
