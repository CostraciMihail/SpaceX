//
//  SXLaunchListViewModel.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation
import Combine

protocol SXLaunchListViewModelInterface: ObservableObject {
 
  func loadLaunches()
  func refreshData()
}

final class SXLaunchListViewModel: NSObject, SXLaunchListViewModelInterface {
  
  @Published var launchesList = [SXLaunchModel]()
  
  var cancellables = Set<AnyCancellable>()
  
  enum Section: CaseIterable {
      case main
  }

  
  func loadLaunches() {
    
    mainAsync(after: 0.5) { [weak self] in
      
      guard let self = self else { return }
      self.launchesList = SXLaunchModel.mocks()
    }
  }
  
  func refreshData() {
    
    loadLaunches()
  }
  
  func clearBindings() {
      
      cancellables.forEach { $0.cancel() }
  }
  
  deinit {
    
    clearBindings()
    
    #if DEBUG
    print("\(self) was deinited")
    #endif
  }
  
}
