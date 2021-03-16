//
//  SXLaunchListViewController.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//

import UIKit
import RxCocoa
import RxSwift

typealias SX_RxLauchListDiffableDataSource = UITableViewDiffableDataSource<SXLaunchListViewModel.Section, SXLaunchModel>

/// SXLaunchListViewController
class SX_RxLaunchListViewController: UIViewController {
  // MARK: - Properties
  //
  var tableView: UITableView!
  var favoritesBarButtonItem: UIBarButtonItem!
  private var refreshControl: UIRefreshControl!
  private var dataSource: SXLauchListDiffableDataSource?
  private var disposeBag = DisposeBag()
  
  var viewModel = SX_RxLaunchListViewModel()
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
    
    viewModel
      .pastLaunchesList
      .subscribe(onNext: { [weak self] launches in
        
        guard let self = self  else { return }
        self.refreshControl.endRefreshing()
        self.reloadDataSources(with: launches)
        
      }, onError: { [weak self] error in
        
        guard let self = self else { return }
        self.refreshControl.endRefreshing()
        showMessage(message: error.localizedDescription, from: self)
        
      }).disposed(by: disposeBag)
    
  }
  
  // MARK: - Actions
  //
  func reloadDataSources(with items: [SXLaunchModel]) {
    
    var snapshot = NSDiffableDataSourceSnapshot<SXLaunchListViewModel.Section, SXLaunchModel>()
    snapshot.appendSections([.main])
    snapshot.appendItems(viewModel.pastLaunchesList.value, toSection: .main)
    dataSource?.apply(snapshot, animatingDifferences: true)
  }
  
  @objc private func refreshData() {
    refreshControl.beginRefreshing()
    viewModel.refreshData()
  }
  
  @objc func favoritesBarButtonAction() {
    router.openFavoritesScreen(from: self)
  }
  
  // MARK: - Deinit
  //
  deinit {
    #if DEBUG
    print("\(self) was deinited")
    #endif
  }
  
}

// MARK: - UITableViewDelegate
//
extension SX_RxLaunchListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    guard let _dataSource = dataSource,
          let selectedCell = _dataSource.tableView(tableView, cellForRowAt: indexPath) as? SXLaunchCell,
          let launchItem = selectedCell.launchItem else {
      return
    }
    
    router.openLauchDetailsScreen(from: self, launchItem: launchItem)
  }
  
}
