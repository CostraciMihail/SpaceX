//
//  SXLaunchDetailsViewController.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import UIKit

class SXLaunchDetailsViewController: UIViewController {
  
  var viewModel: SXLaunchDetailsViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpUI()
  }
  
  func setUpUI() {
    
    title = "Launch Details"
    view.backgroundColor = .orange
    
  }
  
  deinit {
    #if DEBUG
    print("\(self) was deinited")
    #endif
  }
  
}

// MARK: - Storyboard Instantiatable Protocol
//
extension SXLaunchDetailsViewController: SXStoryboardInstantiatable {
  
  static func instantiate(with launchItem: SXLaunchModel) -> SXLaunchDetailsViewController {
    
    let viewModel = SXLaunchDetailsViewModel(launchItem: launchItem)
    let vc = SXLaunchDetailsViewController.instantiate()
    vc.viewModel = viewModel
    return vc
  }
  
}
