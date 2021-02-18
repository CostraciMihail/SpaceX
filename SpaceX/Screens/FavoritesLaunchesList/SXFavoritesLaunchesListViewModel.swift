//
//  SXFavoritesLaunchesListViewModel.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/30/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation
import Combine
import RealmSwift

/// SXFavoritesLaunchesListViewModelInterface
protocol SXFavoritesLaunchesListViewModelInterface: ObservableObject {
  var favoritesLaunches: [SXLaunchModel] { get set }
  var errorPublisher: String? { get set }
  
  func loadFavoritesLaunches()
  func removeFromFavorites(launch: SXLaunchModel)
}

class SXFavoritesLaunchesListViewModel: SXFavoritesLaunchesListViewModelInterface {
  // MARK: - Properties
  //
  @Published var favoritesLaunches = [SXLaunchModel]()
  @Published var errorPublisher: String?
  private var cancellables = Set<AnyCancellable>()
  private var realmNotificationToken: NotificationToken?
  
  // MARK: - Initialization
  //
  init() {
    configureRealmNotificationToken()
  }
  
  // MARK: - Configuration
  //
  func configureRealmNotificationToken() {
    let realm = try! Realm()
    let results = realm.objects(SXLaunchModelDB.self)
    
    realmNotificationToken = results.observe { [ weak self] (changes: RealmCollectionChange) in
      
      guard let self = self else { return }
      
      switch changes {
      case .initial(_): break
      case .update(_, deletions: let deletions, insertions: _, modifications: _):
        _ = deletions.map({ self.favoritesLaunches.remove(at: $0) })
      case .error(let error): print("error: \(error)")
      }
    }
  }
  
  // MARK: - Actions
  //
  func loadFavoritesLaunches() {
    mainAsync { [ weak self] in
      guard let self = self else { return }
      self.favoritesLaunches = SXDatabaseManager.shared.laodFavoritestLaunches()
    }
  }
  
  func removeFromFavorites(launch: SXLaunchModel) {
    SXDatabaseManager.shared.deleteFromFavorites(launchItem: launch)
  }
  
  func clearBindings() {
    cancellables.forEach { $0.cancel() }
    cancellables.removeAll()
  }
  
  // MARK: - Deinit
  //
  deinit {
    clearBindings()
    realmNotificationToken?.invalidate()
    realmNotificationToken = nil
    
    #if DEBUG
    print("\(self) was deinited")
    #endif
  }
  
}

