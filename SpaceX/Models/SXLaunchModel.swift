//
//  SXLaunchModel.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/29/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation

struct SXLaunchModel: Hashable {
  
  var name: String
  var date: Date
  var imageUrl: String
  
  static func mocks() -> [SXLaunchModel] {
    
    var array = [SXLaunchModel]()
    for index in 0...9 {
      
      let launch = SXLaunchModel(name: "Launch-\(index)",
                                 date: Date(),
                                 imageUrl: "launch.links.flickr.\(index)")
      array.append(launch)
    }
    return array
  }
  
}
