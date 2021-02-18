//
//  SXLaunchListRouter.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

/// SXLaunchListRouterInterface
protocol SXLaunchListRouterInterface {
  func openFavoritesScreen(from vc: UIViewController)
  func openLauchDetailsScreen(from vc: UIViewController, launchItem: SXLaunchModel)
}

/// SXLaunchListRouter
/// Provide destinations Screens
struct SXLaunchListRouter: SXLaunchListRouterInterface {
  
  /// Open 'Favorites' Screen
  /// - Parameter vc: from UIViewController
  func openFavoritesScreen(from vc: UIViewController) {
    
    guard let navController = vc.navigationController else {
      return
    }
    
    let viewModel = SXFavoritesLaunchesListViewModel()
    let favoritesLaunchesVC = UIHostingController(rootView: SXFavoritesLaunchesListView(viewModel: viewModel))
    navController.pushViewController(favoritesLaunchesVC, animated: true)
  }
  
  /// Open 'Lauch Detail' screen.
  /// - Parameters:
  ///   - vc: from UIViewController
  ///   - launchItem: launchItem
  func openLauchDetailsScreen(from vc: UIViewController, launchItem: SXLaunchModel) {
    
    guard let navController = vc.navigationController else {
      return
    }
    
    let lauchDetailsVC = SXLaunchDetailsViewController.instantiate(with: launchItem)
    navController.pushViewController(lauchDetailsVC, animated: true)
  }
  
}
