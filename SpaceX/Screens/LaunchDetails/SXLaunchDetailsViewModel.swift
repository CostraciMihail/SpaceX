//
//  SXLaunchDetailsViewModel.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation

/// SXLaunchDetailsViewModelInterface
protocol SXLaunchDetailsViewModelInterface {
  
  var launchItem: SXLaunchModel { get set }
}

/// SXLaunchDetailsViewModel
class SXLaunchDetailsViewModel: SXLaunchDetailsViewModelInterface {
  // MARK: - Properties
  //
  var launchItem: SXLaunchModel
  
  // MARK: - Initialization
  //
  init(launchItem: SXLaunchModel) {
    self.launchItem = launchItem
  }
  
  // MARK: - Deinit
  //
  deinit {
    #if DEBUG
    print("\(self) was deinited")
    #endif
  }
  
}
