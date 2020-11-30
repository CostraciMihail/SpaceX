//
//  SXDatabaseManager.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/30/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation
import RealmSwift

class SXDatabaseManager {
  
  private init() {}
  static var shared = SXDatabaseManager()
  
  func getDB() -> Realm {
    
    let realmConfiguration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    #if DEBUG
    print("Realm file path: \(realmConfiguration.fileURL?.absoluteString ?? "")")
    #endif

    return try! Realm(configuration: realmConfiguration)
  }
  
  func laodFavoritestLaunches() -> [SXLaunchModel] {
    
    let db = getDB()
    let launches = db.objects(SXLaunchModelDB.self)
      .filter({ $0.isFavorite == true })
      .map({ $0.convert() })
    
    return Array(launches)
  }
  
  func saveToFavorites(launchItem: SXLaunchModel) {
    
    let db = getDB()
    let item = launchItem.toDBModel()
    item.isFavorite = true
    try! db.write { db.add(item) }
  }
  
  func deleteFromFavorites(launchItem: SXLaunchModel) {
    
    let db = getDB()
    let objects = db.objects(SXLaunchModelDB.self).filter({ $0.launchID == launchItem.id})
    try! db.write { db.delete(objects) }
  }
  
}
