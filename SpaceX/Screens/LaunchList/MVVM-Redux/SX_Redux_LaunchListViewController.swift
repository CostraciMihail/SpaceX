//
//  SX_Redux_LaunchListViewController.swift
//  SpaceX
//
//  Created by Mihail Costraci on 03/17/21.
//

import UIKit
import Combine

/// SX_Redux_LaunchListViewController
class SX_Redux_LaunchListViewController: UIViewController {
  // MARK: - Properties
  //
  var tableView: UITableView!
  var favoritesBarButtonItem: UIBarButtonItem!
  private var refreshControl: UIRefreshControl!
  private var dataSource: SXLauchListDiffableDataSource?
  private var cancellables: [AnyCancellable] = []
  
  var viewModel = SX_Redux_LaunchListViewModel()
  var router: SXLaunchListRouterInterface = SXLaunchListRouter()
  
  // MARK: - View Lifecycle
  //
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpUI()
    setUpStateChanges()
    viewModel.actions = .loadLaunches
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    refreshControl.endRefreshing()
  }
  
  // MARK: - UI Setups
  //
  func setUpUI() {
    
    title = "SpaceX"
    setUpNavigationBar()
    setUpTable()
    setUpDataSource()
    addRefreshControl()
  }
  
  func setUpNavigationBar() {
    
    favoritesBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(favoritesBarButtonAction))
    
    favoritesBarButtonItem.tintColor = .red
    
    navigationItem.rightBarButtonItem = favoritesBarButtonItem
  }
  
  func setUpTable() {
    
    tableView = UITableView(frame: view.bounds)
    tableView.delegate = self
    tableView.estimatedRowHeight = 60
    tableView.rowHeight = UITableView.automaticDimension
    tableView.separatorStyle = .singleLine
    tableView.separatorColor = .white
    tableView.register(SXLaunchCell.nib, forCellReuseIdentifier: SXLaunchCell.identifier)
    view.addSubview(tableView)
  }
  
  func setUpDataSource() {
    
    dataSource = SXLauchListDiffableDataSource(tableView: tableView,
                                               cellProvider: { table, indexPath, launchItem -> SXLaunchCell? in
                                                
      guard let cell = table.dequeueReusableCell(withIdentifier: SXLaunchCell.identifier,
                                                 for: indexPath) as? SXLaunchCell else {
        return nil
      }
      
      cell.configure(with: launchItem, style: .favorite)
      cell.didPressedFavorite = { [weak self] isFavorite in
        
        guard let self = self else { return }
        self.viewModel.updateFavorites(with: launchItem, isFavorite: isFavorite)
      }
                                                
      return cell
     })
  }
  
  private func addRefreshControl() {
    
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    tableView.refreshControl = refreshControl
  }
  
  func setUpStateChanges() {
    
    viewModel.onStateChange = { [weak self] state in
       
      guard let self = self else { return }
      
      switch state {
      case .default: break
      case .lauchListUpdated:
        print("new items.count: \(self.viewModel.pastLaunchesList)")
        
        mainAsync {
          self.refreshControl.endRefreshing()
          self.reloadDataSources(with: self.viewModel.pastLaunchesList)
        }
        
      case .finishLoading: self.refreshControl.endRefreshing()
        
      case .failLoading(let message):
        mainAsync {
          self.refreshControl.endRefreshing()
          showMessage(message: message, from: self)
        }
      default: break
      }
    }
  }
  
  // MARK: - Actions
  //
  func reloadDataSources(with items: [SXLaunchModel]) {
    
    var snapshot = NSDiffableDataSourceSnapshot<SXLaunchListViewModel.Section, SXLaunchModel>()
    snapshot.appendSections([.main])
    snapshot.appendItems(viewModel.pastLaunchesList, toSection: .main)
    dataSource?.apply(snapshot, animatingDifferences: true)
  }
  
  @objc private func refreshData() {
    refreshControl.beginRefreshing()
    viewModel.actions = .refreshData
  }
  
  @objc func favoritesBarButtonAction() {
    router.openFavoritesScreen(from: self)
  }
  
  func clearBindings() {
    cancellables.forEach { $0.cancel() }
    viewModel.clearBindings()
  }
  
  // MARK: - Deinit
  //
  deinit {
    clearBindings()
    #if DEBUG
    print("\(self) was deinited")
    #endif
  }
  
}

// MARK: - UITableViewDelegate
//
extension SX_Redux_LaunchListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    guard let _dataSource = dataSource,
          let selectedCell = _dataSource.tableView(tableView, cellForRowAt: indexPath) as? SXLaunchCell,
          let launchItem = selectedCell.launchItem else {
      return
    }
    
    router.openLauchDetailsScreen(from: self, launchItem: launchItem)
  }
  
}
