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
  var errorPublisher: String? { get set }
  var service: SXLaunchesAPIServiceInterface { get set }
  
  func loadLaunches()
  func refreshData()
  func updateFavorites(with launchItem: SXLaunchModel, isFavorite: Bool)
}

/// SXLaunchListViewModel
final class SXLaunchListViewModel: NSObject, SXLaunchListViewModelInterface {
  // MARK: - Properties
  //
  @Published var pastLaunchesList = [SXLaunchModel]()
  @Published var errorPublisher: String?
  var service: SXLaunchesAPIServiceInterface
  var cancellables = Set<AnyCancellable>()
  
  /// Section type in DataSource
  enum Section: CaseIterable {
      case main
  }

  // MARK: - Initialization
  //
  init(service: SXLaunchesAPIServiceInterface = SXLaunchesAPIService()) {
    self.service = service
  }
  
  // MARK: - Load Data
  //
  func loadLaunches() {
    
    service
      .getAllPastLaunches()
      .receive(on: DispatchQueue.main)
      .sink { [weak self]  completion in
      
        guard let self = self else { return }

        if case .failure(let error) = completion {
          print("Fail load past launches: \(error)")
          self.errorPublisher = error.localizedDescription
        }
        
    } receiveValue: { [weak self] pastLaunches in
      
      guard let self = self else { return }
      self.pastLaunchesList = pastLaunches
      
    }.store(in: &cancellables)
  }
  
  func refreshData() {
    
    loadLaunches()
  }
  
  func updateFavorites(with launchItem: SXLaunchModel, isFavorite: Bool) {
   
    if isFavorite {
      SXDatabaseManager.shared.deleteFromFavorites(launchItem: launchItem)
      
    } else {
      SXDatabaseManager.shared.saveToFavorites(launchItem: launchItem)
    }
  }
  
  // MARK: - Deinit
  //
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
