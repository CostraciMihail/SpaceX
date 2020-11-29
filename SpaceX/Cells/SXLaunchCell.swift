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
    launchDate.text = launchItem.dateString
  }

  func setUpFavoriteButton(for style: SXLaunchCellStyle) {
   
    switch style {
    case .favorite: favoriteButton.isHidden = false
    default: favoriteButton.isHidden = true
    }
  }
  
  func laodImage() {
    
    var arrayOfLinks = [String]()
    
    let flickrSmallUrls = launchItem?.links?.flickr?.small?.compactMap({ $0 }) ?? []
    let flickrOriginalUrls = launchItem?.links?.flickr?.original?.compactMap({ $0 }) ?? []
    
    let patchSmallUrls = launchItem?.links?.patch?.small
    let patchOriginalUrls = launchItem?.links?.patch?.original
    let patchImageUrls = [patchSmallUrls, patchOriginalUrls].compactMap({ $0 })
    
    arrayOfLinks.append(contentsOf: flickrSmallUrls)
    arrayOfLinks.append(contentsOf: flickrOriginalUrls)
    arrayOfLinks.append(contentsOf: patchImageUrls)

    let imageUrlString = arrayOfLinks.first ?? "empty_url"
    
    let imageURL = URL(string: imageUrlString)
    let imageProcessor = DownsamplingImageProcessor(size: launchImage.bounds.size)
                 |> RoundCornerImageProcessor(cornerRadius: 15) 
    
    launchImage.kf.indicatorType = .activity
    launchImage.kf.setImage(with: imageURL,
                            placeholder: nil,
                            options: [
                              .processor(imageProcessor),
//                              .scaleFactor(UIScreen.main.scale),
                              .transition(.fade(0.05)),
                              .cacheOriginalImage
                            ])
  }
  
}
