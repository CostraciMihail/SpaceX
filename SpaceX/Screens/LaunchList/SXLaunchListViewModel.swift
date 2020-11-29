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
 
  var pastLaunchesList: [SXLaunchModel] { get set }
  var service: SXLaunchesAPIServiceInterface { get set }
  
  func loadLaunches()
  func refreshData()
}

final class SXLaunchListViewModel: NSObject, SXLaunchListViewModelInterface {
  
  @Published var pastLaunchesList = [SXLaunchModel]()
  var service: SXLaunchesAPIServiceInterface
  var cancellables = Set<AnyCancellable>()
  
  enum Section: CaseIterable {
      case main
  }

  init(service: SXLaunchesAPIServiceInterface = SXLaunchesAPIService()) {
    self.service = service
  }
  
  func loadLaunches() {
    
    //
    service
      .getAllPastLaunches()
      .receive(on: DispatchQueue.main)
      .sink { completion in
      
        if case .failure(let error) = completion {
          print("Fail load past launches: \(error)")
        }
        
    } receiveValue: { [weak self] pastLaunches in
      
      guard let self = self else { return }
      self.pastLaunchesList = pastLaunches
      
    }.store(in: &cancellables)

    
    
    
    //
//    mainAsync(after: 0.5) { [weak self] in
//
//      guard let self = self else { return }
//      self.launchesList = SXMock.launchesList()
//    }
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
