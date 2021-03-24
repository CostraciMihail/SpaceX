//
//  SXHelpers.swift
//  SpaceXTests
//
//  Created by Mihail COSTRACI on 25.03.2021.
//  Copyright © 2021 iOSDeveloper. All rights reserved.
//

import Foundation
import XCTest

/// Load Json file from UnitTest Target
/// - Parameter name: file name
/// - Returns: Data from specified file.
func loadJSONData(name: String) -> Data {
  
  let bundle = Bundle(identifier: "com.iOSDeveloper.SpaceXTests")
  
  guard let jsonURL = bundle?.url(forResource: name, withExtension: "json"),
        let jsonData = try? Data(contentsOf: jsonURL) else {
    XCTFail("Cannot read local json file.")
    return Data()
  }
  
  return jsonData
}
