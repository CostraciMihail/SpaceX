//
//  SXHelpers.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/29/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation

func mainAsync(after: TimeInterval = 0, execute closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + after, execute: closure)
}
