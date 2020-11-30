//
//  SXLauncheRowView.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/30/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

/// SXLauncheRowView
struct SXLauncheRowView<Model>: View where Model: SXFavoritesLaunchesListViewModelInterface {
  // MARK: - Properties
  //
  @ObservedObject var viewModel: Model
  var launchItem: SXLaunchModel
  @State var isFavorite: Bool = true
  var imageURL: URL {
    URL(string: launchItem.links?.defaultImage ?? "empty-url")!
  }
  
  var favoriteIcon: some View {
    return Image(systemName: isFavorite ? "star.fill" : "star")
      .frame(width: 40, height: 40)
      .foregroundColor(Color.red)
      .onTapGesture {
        removeFromFavoritesAction()
        isFavorite.toggle()
      }
  }
  
  private var aspectRatio: CGFloat { CGFloat(1.9) }
  
  var body: some View {
    
    VStack(spacing: 10) {
      
      KFImage(imageURL,
              options: [.transition(.fade(0.15)), .cacheOriginalImage])
        .placeholder({ Image("test-luanch-image") })
        .resizable()
        .aspectRatio(aspectRatio, contentMode: .fit)
        .background(Color.black)
        .border(Color("LaunchesListSeparatorColor"), width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
        .cornerRadius(15)
        .overlay(favoriteIcon, alignment: .topTrailing)
      
      HStack(spacing: 0) {
        Text(launchItem.name)
          .font(.system(size: 17, weight: .regular, design: .default))
          .foregroundColor(.nameTextColor)
        
        Spacer()
        
        Text(launchItem.dateString)
          .font(.system(size: 17, weight: .regular, design: .default))
          .foregroundColor(.dateTextColor)
          .padding(.vertical, 5)
          .padding(.horizontal, 5)
          .background(Color(hex: "#A8A9AA"))
      }
      .padding(.horizontal, 8)
      .padding(.bottom, 10)
      
    }
    .padding(.horizontal, 3)
  }
  
  // MARK: - Actions
  //
  private func removeFromFavoritesAction() {
    if isFavorite {
      viewModel.removeFromFavorites(launch: launchItem)
    }
  }
  
}
