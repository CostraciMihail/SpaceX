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
  func openLauchDetailsScreen(from vc: UIViewController, launchItem: SXLaunchModel)
}

struct SXLaunchListRouter: SXLaunchListRouterInterface {
  
  func openFavoritesScreen(from vc: UIViewController) {
    
    guard let _ = vc.navigationController else {
      return
    }
    
    // TODO: Open FavoritesLaunchList Screen
    //
  }
  
  func openLauchDetailsScreen(from vc: UIViewController, launchItem: SXLaunchModel) {
    
    guard let navController = vc.navigationController else {
      return
    }
  
    let lauchDetailsScreen = SXLaunchDetailsViewController.instantiate(with: launchItem)
    navController.pushViewController(lauchDetailsScreen, animated: true)
  }
  
}
