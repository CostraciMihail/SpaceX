//
//  SXLaunchCell.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import UIKit
import Kingfisher

class SXLaunchCell: UITableViewCell {
  
  @IBOutlet weak var launchImage: UIImageView!
  @IBOutlet weak var launchTitle: UILabel!
  @IBOutlet weak var launchDate: UILabel!
  @IBOutlet weak var favoriteButton: UIButton!
  var cellStyle: SXLaunchCellStyle = .default
  
  var launchItem: SXLaunchModel?
  
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
    
    self.launchItem = launchItem
    self.cellStyle = style
    laodImage()
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
  
  func laodImage() {
    
    let imageUrl = URL(string: launchItem?.imageUrl ?? "empty_url")
    let imageProcessor = DownsamplingImageProcessor(size: launchImage.bounds.size)
                 |> RoundCornerImageProcessor(cornerRadius: 15)
    
    launchImage.kf.indicatorType = .activity
    launchImage.kf.setImage(with: imageUrl,
                            placeholder: nil,
                            options: [
                              .processor(imageProcessor),
                              .scaleFactor(UIScreen.main.scale),
                              .transition(.fade(0.5)),
                              .cacheOriginalImage
                            ])
  }
  
}
