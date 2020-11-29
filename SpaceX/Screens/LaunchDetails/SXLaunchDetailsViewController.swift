//
//  SXLaunchDetailsViewController.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import UIKit

class SXLaunchDetailsViewController: UIViewController {
  
  @IBOutlet var youtubeVideoPlayer: UIView!
  @IBOutlet weak var youtubePlayerHeight: NSLayoutConstraint!
  
  var viewModel: SXLaunchDetailsViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpUI()
    adjustYoutubePlayerHeight()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  func setUpUI() {
    
    title = "Launch Details"
    view.backgroundColor = .orange
  }
  
  func adjustYoutubePlayerHeight() {
    
    let screenHeight = self.view.bounds.size.height
    let navBarHeight = self.navigationController?.navigationBar.bounds.size.height ?? 0
    
    let height = (screenHeight - navBarHeight - 100)/2
    self.youtubePlayerHeight.constant = height
    self.youtubeVideoPlayer.layoutIfNeeded()
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
