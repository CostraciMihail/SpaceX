//
//  SXStoryboardInstantiatable.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/29/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation
import UIKit

protocol SXStoryboardInstantiatable {
  static var storyboardName: String { get }
  static var viewControllerIdentifier: String? { get }
  static var bundle: Bundle? { get }
}

extension SXStoryboardInstantiatable where Self: UIViewController {
  
  static var storyboardName: String {
    return String(describing: "Main")
  }
  
  static var viewControllerIdentifier: String? {
    return "\(self)ID"
  }
  
  static var bundle: Bundle? {
    return nil
  }
  
  static func instantiate() -> Self {
    
    let loadViewController = { () -> UIViewController? in
      
      let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
      
      if let viewControllerIdentifier = viewControllerIdentifier {
        return storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
      } else {
        return storyboard.instantiateInitialViewController()
      }
    }
    
    guard let viewController = loadViewController() as? Self else {
      fatalError()
    }
    
    return viewController
  }
}
