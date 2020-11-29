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
  var imageUrl: String = "empty_url"
  
  static func mocks() -> [SXLaunchModel] {
    
    var array = [SXLaunchModel]()
    for index in 0...9 {
      
      let launch = SXLaunchModel(name: "Launch-\(index)",
                                 date: Date(),
                                 imageUrl: "https://live.staticflickr.com/65535/50644831893_bb40b60827_o.jpg")
      array.append(launch)
    }
    return array
  }
  
}
