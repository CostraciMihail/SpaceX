//
//  SXAppContext.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/29/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation

/// SXAppContext
final class SXAppContext {
    
    /// App Bundle ID
    static var bundleID: String {
        return Bundle.main.bundleIdentifier ?? ""
    }
}
