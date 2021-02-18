//
//  SXFavoritesLaunchesListView.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/30/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import SwiftUI

/// SXFavoritesLaunchesListView
struct SXFavoritesLaunchesListView<Model>: View where Model: SXFavoritesLaunchesListViewModelInterface {
  // MARK: - Properties
  //
  @ObservedObject var viewModel: Model
  
  // MARK: - Body
  //
  var body: some View {
    
    GeometryReader { geometry in
      VStack(spacing: 0) {
        
        List {
          ForEach(viewModel.favoritesLaunches, id: \.self) { launchItem in
            SXLauncheRowView(viewModel: viewModel, launchItem: launchItem)
          }
          .background(Color.mainBackgroundColor)
          .frame(width: geometry.size.width)
          .offset(x: -15)
          .listRowInsets(EdgeInsets(top: 1, leading: 15, bottom: 1, trailing: 15))
        }
        .onAppear(perform: {
          UITableView.appearance().separatorStyle = .singleLine
          UITableView.appearance().separatorColor = UIColor.separator
        })
      }
      .navigationBarTitle("Favorites")
      .onAppear(perform: {
        viewModel.loadFavoritesLaunches()
      })
    }
  }
  
}

// MARK: - PreviewProvider
//
struct SXFavoritesLaunchesListView_Previews: PreviewProvider {
  static var previews: some View {
    SXFavoritesLaunchesListView(viewModel: SXFavoritesLaunchesListViewModel())
  }
}
