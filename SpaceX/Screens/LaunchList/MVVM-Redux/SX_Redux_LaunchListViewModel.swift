//
//  SXLaunchListViewModel.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation
import Combine

/// SXLaunchListViewModelInterface
protocol SX_Redux_LaunchListViewModelInterface: ObservableObject {
  var pastLaunchesList: [SXLaunchModel] { get set }
  var service: SXLaunchesAPIServiceInterface { get set }
  
  func loadLaunches()
  func refreshData()
  func updateFavorites(with launchItem: SXLaunchModel, isFavorite: Bool)
}

/// SXLaunchListViewModel
final class SX_Redux_LaunchListViewModel: NSObject, SX_Redux_LaunchListViewModelInterface {
  // MARK: - Properties
  //
  var pastLaunchesList = [SXLaunchModel]()
  public var onStateChange: ((SX_Redux_LaunchListState) -> Void)?
  private(set) var state: SX_Redux_LaunchListState
  var service: SXLaunchesAPIServiceInterface
  var cancellables = Set<AnyCancellable>()
  
  /// Section type in DataSource
  enum Section: CaseIterable {
    case main
  }
  
  public enum SX_Redux_LaunchListState {
    case `default`,
         loading,
         finishLoading,
         failLoading(message: String),
         lauchListUpdated,
         favoriteListUpdated
  }
  
  public enum SX_Redux_LaunchListActions {
    case none
    case loadLaunches
    case refreshData
    case updateFavoritesWith(launchItem: SXLaunchModel, isFavorite: Bool)
  }
  
  public var actions: SX_Redux_LaunchListActions {
    willSet {
      switch newValue {
      case .loadLaunches: loadLaunches()
      case .refreshData: refreshData()
      default: break
      }
    }
  }
  
  // MARK: - Initialization
  //
  init(service: SXLaunchesAPIServiceInterface = SXLaunchesAPIService(),
       state: SX_Redux_LaunchListState = .default) {
    
    self.service = service
    self.state = state
    self.actions = .none
    onStateChange?(state)
  }
  
  // MARK: - Load Data
  //
  func loadLaunches() {
    
    onStateChange?(SX_Redux_LaunchListState.loading)
    
    service
      .getAllPastLaunches()
      .receive(on: DispatchQueue.main)
      .sink { [weak self]  completion in
        
        guard let self = self else { return }
        
        if case .failure(let error) = completion {
          print("Fail load past launches: \(error)")
          self.onStateChange?(SX_Redux_LaunchListState.failLoading(message: error.localizedDescription))
        }
        
      } receiveValue: { [weak self] pastLaunches in
        
        guard let self = self else { return }
        self.pastLaunchesList = pastLaunches
        self.onStateChange?(SX_Redux_LaunchListState.finishLoading)
        self.onStateChange?(SX_Redux_LaunchListState.lauchListUpdated)
        
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
    
    onStateChange?(SX_Redux_LaunchListState.favoriteListUpdated)
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
