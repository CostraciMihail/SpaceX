//
//  SXLaunchModelDB.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/30/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation
import RealmSwift

/// SXLaunchModelDB
class SXLaunchModelDB: Object, NSCopying {
  // MARK: - Properties
  //
  @objc dynamic var id: Int = Int.random(in: 0...100000)
  @objc dynamic var launchID: String = "\(Int.random(in: 0...100000))"
  @objc dynamic var isFavorite: Bool = false
  @objc dynamic var name: String = ""
  @objc dynamic var details: String?
  @objc dynamic var imageUrl: String?
  let staticFireDateUnix = RealmOptional<Double>()
  let payloads = List<String>()
  
  // MARK: - Initialization
  //
  convenience init(id: Int = Int.random(in: 0...100000),
                   launchID: String = "\(Int.random(in: 0...100000))",
                   name: String = "",
                   details: String? = nil,
                   imageUrl: String? = nil,
                   staticFireDateUnix: Double? = nil,
                   isFavorite: Bool = false) {
    
    self.init()
    self.id = id
    self.launchID = launchID
    self.name = name
    self.details = details
    self.imageUrl = imageUrl
    self.staticFireDateUnix.value = staticFireDateUnix
    self.isFavorite = isFavorite
  }
  
  override class func primaryKey() -> String? {
      return "id"
  }
  // MARK: - NSCopying
  //
  func copy(with zone: NSZone? = nil) -> Any {
    
    return SXLaunchModelDB(id: id,
                           launchID: launchID,
                           name: name,
                           details: details,
                           imageUrl: imageUrl,
                           staticFireDateUnix: staticFireDateUnix.value,
                           isFavorite: isFavorite)
  }
  
  // MARK: - Helpers
  //
  func convert() -> SXLaunchModel {
    
    let imageLinks = SXImageLinks(patch: SXIPatchImageSize(small: imageUrl,
                                                                  original: nil))
    
    return SXLaunchModel(id: launchID,
                         name: name,
                         details: details,
                         staticFireDateUnix: staticFireDateUnix.value,
                         links: imageLinks,
                         payloads: nil)
  }
}

