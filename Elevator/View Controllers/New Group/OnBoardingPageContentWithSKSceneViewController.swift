//
//  OnBoardingPageContentWithSKSceneViewController.swift
//  Elevator
//
//  Created by David Witt on 2018-07-12.
//  Copyright © 2018 David Witt. All rights reserved.
//

import UIKit
import SpriteKit

class OnBoardingPageContentWithSKSceneViewController: OnBoardingPageContentViewController {
  
  var animationScene = AnimationScene.init(size: CGSize(width: 330 , height: 495))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    //animationScene.anchorPoint = CGPoint(x: 0.5  , y: 0.5)
    
    skView.showsFPS = false
    skView.showsNodeCount = false
    skView.presentScene(animationScene)
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    
  @IBOutlet weak var skView: SKView!
  
  @IBAction func getStartedButtonPressed() {
    
    let storyboard = self.storyboard
    
    // The following page view controller should be the same as the rootViewController
    let parentPageViewController = self.parent
    parentPageViewController?.view.removeFromSuperview()
    
    // create the navigationController
    let navigationController = storyboard?.instantiateViewController(withIdentifier: "mainNavigationController") as? UINavigationController
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window?.rootViewController = navigationController
    
    appDelegate.injectViewModelDependencyInto(navigationController?.viewControllers.first as? elevatorTableViewController)
    
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
