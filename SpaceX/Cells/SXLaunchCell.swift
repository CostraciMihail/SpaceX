//
//  SXLaunchCell.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import UIKit
import Kingfisher

/// SXLaunchCell
class SXLaunchCell: UITableViewCell {
  // MARK: - Properties
  //
  @IBOutlet weak var launchImage: UIImageView!
  @IBOutlet weak var launchTitle: UILabel!
  @IBOutlet weak var launchDate: UILabel!
  @IBOutlet weak var favoriteButton: UIButton!
  var cellStyle: SXLaunchCellStyle = .default
  var launchItem: SXLaunchModel?
  var isFavorite: Bool = false
  var didPressedFavorite: ((Bool) -> ())?
  
  enum SXLaunchCellStyle {
    case favorite, `default`
  }
  
  // MARK: - Configuration
  //
  override func awakeFromNib() {
    super.awakeFromNib()
  
    setUpFavoriteButton(for: cellStyle)
    launchImage.layer.borderWidth = 1
    launchImage.layer.borderColor = UIColor.LaunchesListSeparatorColor.cgColor
  }
  
  func configure(with launchItem: SXLaunchModel,
                 style: SXLaunchCellStyle,
                 isFavorite: Bool = false) {
    
    self.isFavorite = isFavorite
    self.launchItem = launchItem
    self.cellStyle = style
    laodImage()
    setUpFavoriteButton(for: style)
    
    launchTitle.text = launchItem.name
    launchDate.text = launchItem.dateString
  }

  func setUpFavoriteButton(for style: SXLaunchCellStyle) {
   
    switch style {
    case .favorite:
      favoriteButton.isHidden = false
    default:
      favoriteButton.isHidden = true
    }
    
    favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
    favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
    favoriteButton.isSelected = isFavorite
    favoriteButton.addTarget(self,
                             action: #selector(didPressedFavoriteButton),
                             for: .touchUpInside)
  }
  
  // MARK: - Actions
  //
  func laodImage() {
    
    guard let imageUrl = launchItem?.links?.defaultImage else {
      return
    }
    
    let imageProcessor = DownsamplingImageProcessor(size: launchImage.bounds.size)
                 |> RoundCornerImageProcessor(cornerRadius: 15) 
    
    launchImage.kf.indicatorType = .activity
    launchImage.kf.setImage(with: URL(string: imageUrl),
                            placeholder: nil,
                            options: [
                              .processor(imageProcessor),
                              .transition(.fade(0.05)),
                              .cacheOriginalImage,
                            ])
  }
  
  @objc func didPressedFavoriteButton(_ sender: UIButton) {
    favoriteButton.isSelected = !favoriteButton.isSelected
    isFavorite = !favoriteButton.isSelected
    didPressedFavorite?(isFavorite)
  }
  
}
