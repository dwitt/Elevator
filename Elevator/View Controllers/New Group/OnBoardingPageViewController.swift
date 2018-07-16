//
//  OnBoardingPageViewController.swift
//  Elevator
//
//  Created by David Witt on 2018-07-05.
//  Copyright © 2018 David Witt. All rights reserved.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {
  
  var currentPage = 0
  var totalPages = 2
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.dataSource = self
    
    let viewController = storyboard?.instantiateViewController(withIdentifier: "page0") as! OnBoardingPageContentViewController
    viewController.pageIndex = 0
    
    
    self.setViewControllers([viewController], direction: .forward, animated: false)
    
    // Do any additional setup after loading the view.

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

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    for view in self.view.subviews {
      if view.isKind(of: UIScrollView.self ) {
        view.frame = self.view.bounds
        
      }
//      if view.isKind(of: UIPageControl.self) {
//        //let pageControlView = view as! UIPageControl
//        //pageControlView.pageIndicatorTintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.2529163099)
//        //pageControlView.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
//      }
    }
  }
  
}

extension OnBoardingPageViewController: UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    
    let onBoardingPageContentViewController: OnBoardingPageContentViewController = viewController as! OnBoardingPageContentViewController
    
    var index = onBoardingPageContentViewController.pageIndex
    if index  < (totalPages - 1) {
      index = index + 1
      return contentViewControllerAt(index)
        

    }
    return nil
  }
 
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    let onBoardingPageContentViewController = viewController as! OnBoardingPageContentViewController
    
    var index = onBoardingPageContentViewController.pageIndex
    if index > 0 {
      index = index - 1
      return contentViewControllerAt(index)
    }
    return nil
  }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return totalPages
  }
  
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return currentPage
  }
  
  func contentViewControllerAt(_ index: Int) -> OnBoardingPageContentViewController {
    
    var contentViewController: OnBoardingPageContentViewController
    
    if index != 1 {
      contentViewController = storyboard?.instantiateViewController(withIdentifier: "page\(index)") as! OnBoardingPageContentViewController
    } else {
      contentViewController = storyboard?.instantiateViewController(withIdentifier: "page\(index)") as! OnBoardingPageContentWithSKSceneViewController
    }
    
    contentViewController.pageIndex = index
    return contentViewController
  }
  
}
