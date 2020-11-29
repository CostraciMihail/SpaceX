//
//  SXLaunchCell.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import UIKit

class SXLaunchCell: UITableViewCell {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    disableSelection()
  }
  
  func configure(with launchItem: SXLaunchModel) {
    
    textLabel?.text = launchItem.name
  }
  
}
