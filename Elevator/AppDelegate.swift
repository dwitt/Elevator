//
//  AppDelegate.swift
//  Elevator
//
//  Created by David Witt on 2018-01-25.
//  Copyright © 2018 David Witt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      // Override point for customization after application launch.
      
      injectViewModelDependencyIntoViewController()
      
      return true
    }
  
  // TO create the data models, we check if the navigation controller is not nil and if the first view controller inside
  // the navigation controller is not nil and if so we create the data models inside the initial view controller
  
  func injectViewModelDependencyIntoViewController() {
    
    if let navigationController = window?.rootViewController as? UINavigationController,
      let initialViewController = navigationController.viewControllers.first as? elevatorTableViewController {
      
      // Dependency injection
      initialViewController.viewModel = createElevatorViewModel()
      
    }
  }
  
  func createElevatorViewModel() -> ElevatorViewModel {
    let elevator = createElevatorModel()
    let elevatorViewModel = ElevatorViewModel(elevator)
    return elevatorViewModel
  }
  
  private func createElevatorModel() -> Elevator {
    // TODO: remove the next line - It should no longer be needed
    // elevator = Elevator(ratedSpeed: MyMeasurement(of: .speed, value: 0.5, units: .metric), capacity: 1361, governorSpeedReducingSwitch: false, staticControl: true)
    let elevator = Elevator(ratedSpeed: Measurement(value: 0.5, unit: .metersPerSecond), capacity: 1361, governorSpeedReducingSwitch: false, staticControl: true)
    return elevator
  }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

