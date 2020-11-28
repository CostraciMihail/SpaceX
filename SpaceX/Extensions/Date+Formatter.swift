//
//  Date+Formatter.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/29/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation

extension Date {
  
  ///   Date string from date.
  ///
  ///     Date().string(withFormat: "dd/MM/yyyy") -> "1/12/17"
  ///     Date().string(withFormat: "HH:mm") -> "23:50"
  ///     Date().string(withFormat: "dd/MM/yyyy HH:mm") -> "1/12/17 23:50"
  ///
  /// - Parameter format: Date format (default is "dd/MM/yyyy").
  /// - Returns: date string.
  public func string(withFormat format: String = "dd/MM/yyyy HH:mm") -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }
  
}
