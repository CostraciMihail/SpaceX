//
//  SXAppContext.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/29/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation
import UIKit

/// SXAppContext
final class SXAppContext {
  
  /// App Bundle ID
  static var bundleID: String {
    return Bundle.main.bundleIdentifier ?? ""
  }
  
  /// Screen Height
  static var screenHeight: CGFloat {
    UIScreen.main.bounds.size.height
  }
  
  /// Screen Width
  static var screenWidth: CGFloat {
    UIScreen.main.bounds.size.width
  }
}
