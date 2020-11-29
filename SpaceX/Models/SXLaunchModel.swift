//
//  SXLaunchModel.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/29/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation

struct SXLaunchModel: Hashable {
  
  var id: String
  var name: String
  var details: String?
  var date: Date
  var imageUrl: String = "empty_url"
  var youtubeID: String?
  var wikipedia: String?
  var payloadMass: String?
  
  var dateString: String {
    date.string(withFormat: "MMMM d, yyyy")
  }
  
  static func mocks() -> [SXLaunchModel] {
    
    let details = "This mission will launch the fifteenth batch of operational Starlink satellites, which are version 1.0, from SLC-40, Cape Canaveral Air Force Station. It will be the sixteenth Starlink launch overall. The satellites will be delivered to low Earth orbit and will spend a few weeks maneuvering to their operational altitude of 550 km. The booster for this mission is expected to land on an ASDS."
    
    var array = [SXLaunchModel]()
    for index in 0...9 {
      
      let launch = SXLaunchModel(id: "5fb95b3f3a88ae63c954603c",
                                name: "Starlink-\(index) (v1.0)",
                                 details: details,
                                 date: Date(),
                                 imageUrl: "https://live.staticflickr.com/65535/50644831893_bb40b60827_o.jpg",
                                 youtubeID: "M7lc1UVf-VE",
                                 wikipedia: "https://en.wikipedia.org/wiki/Starlink",
                                 payloadMass: "2760.0 kg")
      array.append(launch)
    }
    return array
  }
  
}
