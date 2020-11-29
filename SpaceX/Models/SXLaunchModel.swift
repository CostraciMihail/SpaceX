//
//  SXLaunchModel.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/29/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation

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
}

protocol SXIArrayImageSize {
  var small: [String]? { get set }
  var original: [String]? { get set }
}

protocol SXIStringImageSize {
  var small: String? { get set }
  var original: String? { get set }
}

struct SXIPatchImageSize: Codable, Hashable, SXIStringImageSize {
  var small: String?
  var original: String?
}

struct SXIFickrImageSize: Codable, Hashable, SXIArrayImageSize {
  var small: [String]?
  var original: [String]?
}

struct SXImageLinks: Codable, Hashable {
  var patch: SXIPatchImageSize?
  var flickr: SXIFickrImageSize?
  var youtubeID: String?
  var wikipedia: String?
}
