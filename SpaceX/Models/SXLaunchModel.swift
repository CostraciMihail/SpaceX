//
//  SXLaunchModel.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/29/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation
import RealmSwift

/// SXLaunchModel
struct SXLaunchModel: Codable, Hashable {
  var id: String
  var name: String
  var details: String?
  var staticFireDateUnix: Double?
  var links: SXImageLinks?
  var payloads: [String]?
  var dateString: String {
    guard let date = staticFireDateUnix else { return "-- -- --" }
    return Date(timeIntervalSince1970: date).string(withFormat: "MMMM d, yyyy")
  }
  
  func toDBModel() -> SXLaunchModelDB {
    return SXLaunchModelDB(launchID: id,
                           name: name,
                           imageUrl: links?.defaultImage,
                           staticFireDateUnix: staticFireDateUnix)
  }
}

/// SXIArrayImageSize
protocol SXIArrayImageSize {
  var small: [String]? { get set }
  var original: [String]? { get set }
}

/// SXIStringImageSize
protocol SXIStringImageSize {
  var small: String? { get set }
  var original: String? { get set }
}

/// SXIPatchImageSize
struct SXIPatchImageSize: Codable, Hashable, SXIStringImageSize {
  var small: String?
  var original: String?
}

/// SXIFickrImageSize
struct SXIFickrImageSize: Codable, Hashable, SXIArrayImageSize {
  var small: [String]?
  var original: [String]?
}

/// SXImageLinks
struct SXImageLinks: Codable, Hashable {
  // MARK: - Properties
  //
  /// First url from 'allImagesUrls()' function.
  var defaultImage: String {
    allImagesUrls().first ?? "empty-url"
  }
  var patch: SXIPatchImageSize?
  var flickr: SXIFickrImageSize?
  var youtubeID: String?
  var wikipedia: String?
  
  /// Check and return an array of all available images urls.
  /// - Returns: An Array of images urls.
  func allImagesUrls() -> [String] {
    
    var arrayOfLinks = [String]()
    let flickrSmallUrls = flickr?.small?.compactMap({ $0 }) ?? []
    let flickrOriginalUrls = flickr?.original?.compactMap({ $0 }) ?? []
    let patchSmallUrls = patch?.small
    let patchOriginalUrls = patch?.original
    let patchImageUrls = [patchSmallUrls, patchOriginalUrls].compactMap({ $0 })
    
    arrayOfLinks.append(contentsOf: flickrSmallUrls)
    arrayOfLinks.append(contentsOf: flickrOriginalUrls)
    arrayOfLinks.append(contentsOf: patchImageUrls)

    return arrayOfLinks
  }
}
