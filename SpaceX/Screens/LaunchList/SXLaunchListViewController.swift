//
//  SXLaunchListViewController.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//

import UIKit

class SXLaunchListViewController: UIViewController {

  var viewModel = SXLaunchListViewModel()
  var router: SXLaunchListRouterInterface = SXLaunchListRouter()
  var favoritesBarButtonItem: UIBarButtonItem!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpUI()
  }

  
  func setUpUI() {
    
    title = "SpaceX"
    setUpNavigationBar()
  }

  func setUpNavigationBar() {
    
    favoritesBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(favoritesBarButtonAction))
    
    navigationItem.rightBarButtonItem = favoritesBarButtonItem
  }
  
  @objc func favoritesBarButtonAction() {
    
    router.openFavoritesScreen(from: self)
  }
  
}

