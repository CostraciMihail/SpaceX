//
//  SXHelpers.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/29/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation
import UIKit

/// Shortcut for DispatchQueue.main.asyncAfter()
/// - Parameters:
///   - after: after TimeInterval
///   - closure: closure to trigger
func mainAsync(after: TimeInterval = 0, execute closure: @escaping () -> Void) {
  DispatchQueue.main.asyncAfter(deadline: .now() + after, execute: closure)
}

/// An shortcut to show an UIAlertController with specified message.
/// - Parameters:
///   - title: Alert title
///   - message: Alert message
///   - from: UIViewController from which to show alert
///   - handler: action handler
func showMessage(_ title: String? = nil,
                 message: String,
                 from: UIViewController,
                 handler: ((UIAlertAction) -> Void)? = nil) {
  
  let alertController = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
  
  let dismissAction = UIAlertAction(title: "OK",
                                    style: .default,
                                    handler: handler)
  
  alertController.addAction(dismissAction)
  
  mainAsync {
    from.present(alertController, animated: true, completion: nil)
  }
  
}
