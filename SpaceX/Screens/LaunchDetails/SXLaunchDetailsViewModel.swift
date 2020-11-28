//
//  SXLaunchDetailsViewModel.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation

protocol SXLaunchDetailsViewModelInterface {
  
  var launchItem: SXLaunchModel { get set }
}

class SXLaunchDetailsViewModel: SXLaunchDetailsViewModelInterface {
  
  var launchItem: SXLaunchModel
  
  init(launchItem: SXLaunchModel) {
    
    self.launchItem = launchItem
  }
  
  deinit {
    #if DEBUG
    print("\(self) was deinited")
    #endif
  }
  
}
