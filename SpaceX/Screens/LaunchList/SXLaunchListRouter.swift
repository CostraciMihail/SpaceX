//
//  SXLaunchListRouter.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation
import UIKit

protocol SXLaunchListRouterInterface {
  
  func openFavoritesScreen(from vc: UIViewController)
}

struct SXLaunchListRouter: SXLaunchListRouterInterface {
  
  func openFavoritesScreen(from vc: UIViewController) {
    
    guard let navController = vc.navigationController else {
      return
    }
    
    let lauchDetailsScreen = SXLaunchDetailsViewController()
    navController.pushViewController(lauchDetailsScreen, animated: true)
  }
  
}
