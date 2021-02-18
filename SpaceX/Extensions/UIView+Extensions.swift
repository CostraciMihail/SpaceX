//
//  UIView+Extension.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/29/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  
  /// Make round corners to UIView
  /// - Parameters:
  ///   - cornerRadius: cornerRadius
  ///   - corners: wich corners to apply corner radius
  func roundCorners(cornerRadius: Double, corners: UIRectCorner) {
    
    let cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)
    let path = UIBezierPath(roundedRect: self.bounds,
                            byRoundingCorners: corners,
                            cornerRadii: cornerRadii)
    
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.bounds
    maskLayer.path = path.cgPath
    self.layer.mask = maskLayer
  }
  
}
