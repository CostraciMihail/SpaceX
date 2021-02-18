//
//  SXLaunchListViewController.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//

import UIKit
import Combine

typealias SXLauchListDiffableDataSource = UITableViewDiffableDataSource<SXLaunchListViewModel.Section, SXLaunchModel>

/// SXLaunchListViewController
class SXLaunchListViewController: UIViewController {
  // MARK: - Properties
  //
  var tableView: UITableView!
  var favoritesBarButtonItem: UIBarButtonItem!
  private var refreshControl: UIRefreshControl!
  private var dataSource: SXLauchListDiffableDataSource?
  private var cancellables: [AnyCancellable] = []
  
  var viewModel = SXLaunchListViewModel()
  var router: SXLaunchListRouterInterface = SXLaunchListRouter()
  
  // MARK: - View Lifecycle
  //
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpUI()
    setUpBindings()
    viewModel.loadLaunches()
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
  
  func setUpBindings() {
    
    viewModel.$pastLaunchesList
      .dropFirst()
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] items in
        
        print("new items.count: \(items.count)")
        
        guard let self = self else { return }
        mainAsync {
          self.refreshControl.endRefreshing()
          self.reloadDataSources(with: items)
        }
        
      }).store(in: &cancellables)
    
    
    viewModel.$errorPublisher
      .dropFirst()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] messageText in
        
        guard let self = self, let _messageText = messageText else { return }
        self.refreshControl.endRefreshing()
        showMessage(message: _messageText, from: self)
        
      }.store(in: &cancellables)
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
    viewModel.refreshData()
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
extension SXLaunchListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    guard let _dataSource = dataSource,
          let selectedCell = _dataSource.tableView(tableView, cellForRowAt: indexPath) as? SXLaunchCell,
          let launchItem = selectedCell.launchItem else {
      return
    }
    
    router.openLauchDetailsScreen(from: self, launchItem: launchItem)
  }
  
}
