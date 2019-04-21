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
  let defaults = UserDefaults.standard

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // Override point for customization after application launch.
    
    let currentViewController = self.window?.rootViewController as? UINavigationController
    let storyboard = currentViewController?.storyboard
    
    injectViewModelDependencyInto(currentViewController?.viewControllers.first as? elevatorTableViewController)
    
    // Temporary test for page view onboarding feature
    
    if !onBoardingComplete() {
    
      let onBoardingPageViewController = storyboard?.instantiateViewController(withIdentifier: "pageViewController") as! UIPageViewController
      
      
      
      self.window?.rootViewController = onBoardingPageViewController

      defaults.set(true, forKey: "onBoarding")
      
    }
    
    
    

    
    return true
  }
  
  // TO create the data models, we check if the navigation controller is not nil and if the first view controller inside
  // the navigation controller is not nil and if so we create the data models inside the initial view controller
  
  func injectViewModelDependencyInto(_ viewController: elevatorTableViewController?) {

    // Dependency injection
    if viewController != nil {
      viewController!.viewModel = createElevatorViewModel()
    }
  }
  
  
  func createElevatorViewModel() -> ElevatorViewModel {
    let elevator = createElevatorModel()
    let elevatorViewModel = ElevatorViewModel(elevator)
    return elevatorViewModel
  }
  
  private func createElevatorModel() -> Elevator {
    let elevator = Elevator(ratedSpeed: Measurement(value: 0.5, unit: .metersPerSecond), capacity: 1361, governorSpeedReducingSwitch: false, staticControl: true)
    return elevator
  }
  
  private func onBoardingComplete() -> Bool {
    return defaults.bool(forKey: "onBoarding")
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

