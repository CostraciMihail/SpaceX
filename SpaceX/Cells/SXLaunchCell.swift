//
//  SXLaunchCell.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import UIKit

class SXLaunchCell: UITableViewCell {
  
  @IBOutlet weak var launchImage: UIImageView!
  @IBOutlet weak var launchTitle: UILabel!
  @IBOutlet weak var launchDate: UILabel!
  
  @IBOutlet weak var favoriteButton: UIButton!
  var cellStyle: SXLaunchCellStyle = .default
  
  enum SXLaunchCellStyle {
    case favorite, `default`
  }

  
  override func awakeFromNib() {
    super.awakeFromNib()
  
    setUpFavoriteButton(for: cellStyle)
    launchImage.layer.borderWidth = 1
    launchImage.layer.borderColor = UIColor.launchesListSeparatorColor.cgColor
  }
  
  func configure(with launchItem: SXLaunchModel, style: SXLaunchCellStyle) {
    
    self.cellStyle = style
    setUpFavoriteButton(for: style)
    
    launchTitle.text = launchItem.name
    launchDate.text = launchItem.date.string(withFormat: "MMMM d, yyyy")
  }

  func setUpFavoriteButton(for style: SXLaunchCellStyle) {
   
    switch style {
    case .favorite: favoriteButton.isHidden = false
    default: favoriteButton.isHidden = true
    }
  
  }
  
  
}
