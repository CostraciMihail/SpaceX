//
//  SXMock.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/30/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation

/// Mock struct which contain different mocks of models.
struct SXMock {
  
  static let wikipediaUrl = "https://en.wikipedia.org/wiki/Starlink"
  static let originalImage1 = "https://live.staticflickr.com/65535/50644831893_bb40b60827_o.jpg"
  
  static let originalImage2 = "https://live.staticflickr.com/65535/50645580736_44af27257f_o.jpg"
  
  static let dateUnix = TimeInterval(1605976260)
  
  static func launchesList() -> [SXLaunchModel] {
    
    let details = "This mission will launch the fifteenth batch of operational Starlink satellites, which are version 1.0, from SLC-40, Cape Canaveral Air Force Station. It will be the sixteenth Starlink launch overall. The satellites will be delivered to low Earth orbit and will spend a few weeks maneuvering to their operational altitude of 550 km. The booster for this mission is expected to land on an ASDS."
    
    let imageSize = SXIFickrImageSize(small: [],
                                      original: [originalImage1, originalImage2])
    
    let imageLink = SXImageLinks(flickr: imageSize,
                                 youtubeID: "M7lc1UVf-VE",
                                 wikipedia: wikipediaUrl)
    
    
    var array = [SXLaunchModel]()
    for index in 0...9 {
      
      let launch = SXLaunchModel(id: "\(index)",
                                 name: "Starlink-\(index) (v1.0)",
                                 details: details,
                                 staticFireDateUnix: dateUnix,
                                 links: imageLink,
                                 payloads: ["2760.0 kg"])
      array.append(launch)
    }
    return array
  }
  
}
