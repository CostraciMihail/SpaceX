//
//  SX_RxLaunchListViewModel.swift
//  SpaceX
//
//  Created by Mihail Costraci on 03/16/21.
//  Copyright © 2021 iOSDeveloper. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// SXLaunchListViewModelInterface
protocol SX_RxLaunchListViewModelInterface: ObservableObject {
  var pastLaunchesList: BehaviorRelay<[SXLaunchModel]> { get set }
  var errorPublisher: String? { get set }
  var service: SX_RxLaunchesAPIServiceInterface { get set }
  
  func loadLaunches()
  func refreshData()
  func updateFavorites(with launchItem: SXLaunchModel, isFavorite: Bool)
}

/// SXLaunchListViewModel
final class SX_RxLaunchListViewModel: NSObject, SX_RxLaunchListViewModelInterface {
  // MARK: - Properties
  //
  var pastLaunchesList: BehaviorRelay<[SXLaunchModel]> = BehaviorRelay<[SXLaunchModel]>(value: [])
  var errorPublisher: String?
  var service: SX_RxLaunchesAPIServiceInterface
  var disposeBag = DisposeBag()
  
  /// Section type in DataSource
  enum Section: CaseIterable {
    case main
  }
  
  // MARK: - Initialization
  //
  init(service: SX_RxLaunchesAPIServiceInterface = SX_RxLaunchesAPIService()) {
    self.service = service
  }
  
  // MARK: - Load Data
  //
  func loadLaunches() {
    
    service.getAllPastLaunches()
      .observe(on: MainScheduler.instance)
      .bind(onNext: { [weak self] loadedLaunches in
        
        guard let self = self else { return }
        self.pastLaunchesList.accept(loadedLaunches)
       
        // TODO: Trate when an error will occur
        //
      })
      .disposed(by: disposeBag)
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
  deinit {
        
    #if DEBUG
    print("\(self) was deinited")
    #endif
  }
  
}
