//
//  UITableViewCell+Extension.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import UIKit

extension UITableViewCell {
  
  static var nib: UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
  
  static var identifier: String {
    return String(describing: self)
  }
  
  func disableSelection() {
    selectionStyle = .none
  }
  
}
