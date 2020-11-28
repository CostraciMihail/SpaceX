//
//  SXLaunchDetailsViewController.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import UIKit

class SXLaunchDetailsViewController: UIViewController {
  
  var viewModel: SXLaunchDetailsViewModel
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    viewModel = SXLaunchDetailsViewModel()
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  init(viewModel: SXLaunchDetailsViewModel = SXLaunchDetailsViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
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
