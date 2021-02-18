//
//  SXLaunchDetailsViewController.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

/// SXLaunchDetailsViewController
class SXLaunchDetailsViewController: UIViewController {
  // MARK: - Properties
  //
  @IBOutlet var youtubeVideoPlayer: YTPlayerView!
  @IBOutlet weak var youtubePlayerHeight: NSLayoutConstraint!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var payloadLabel: UILabel!
  
  var viewModel: SXLaunchDetailsViewModel!

  // MARK: - View Lifecycle
  //
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpUI()
    loadVideo()
    adjustYoutubePlayerHeight()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
   
    setUpYoutubePlayer()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
   
    youtubeVideoPlayer.delegate = nil
  }
  
  // MARK: - UI Setups
  //
  func setUpUI() {
    
    title = viewModel.launchItem.name
    dateLabel.text = viewModel.launchItem.dateString
    descriptionLabel.text = viewModel.launchItem.details
    nameLabel.text = "Rocket name: \(viewModel.launchItem.name)"
    payloadLabel.text = "Payload mass: \(viewModel.launchItem.payloads?.first ?? "*")"
  }
  
  func adjustYoutubePlayerHeight() {
    
    let screenHeight = self.view.bounds.size.height
    let navBarHeight = self.navigationController?.navigationBar.bounds.size.height ?? 0
    
    let height = (screenHeight - navBarHeight - 100)/2
    self.youtubePlayerHeight.constant = height
    self.youtubeVideoPlayer.layoutIfNeeded()
  }
  
  func setUpYoutubePlayer() {
    
    youtubeVideoPlayer.delegate = self
  }
  
  // MARK: - Actions
  //
  func loadVideo() {
    
    mainAsync(after: 0.05) { [weak self] in
      guard let self = self else { return }
      self.youtubeVideoPlayer.load(withVideoId: self.viewModel.launchItem.links?.youtubeID ?? "empty_id")
    }
  }
  
  @IBAction func didPressWikipediaButton(_ sender: Any) {
    
    openWikipediaURL()
  }
  
  func openWikipediaURL() {
    
    let url = URL(string: viewModel.launchItem.links?.wikipedia ?? "empty_url")!
    guard UIApplication.shared.canOpenURL(url) else { return }
    
    UIApplication.shared.open(url)
  }
  
  // MARK: - Deinit
  //
  deinit {
    #if DEBUG
    print("\(self) was deinited")
    #endif
  }
  
}

// MARK: - Storyboard Instantiatable Protocol
//
extension SXLaunchDetailsViewController: SXStoryboardInstantiatable {
  
  static func instantiate(with launchItem: SXLaunchModel) -> SXLaunchDetailsViewController {
    
    let viewModel = SXLaunchDetailsViewModel(launchItem: launchItem)
    let vc = SXLaunchDetailsViewController.instantiate()
    vc.viewModel = viewModel
    return vc
  }
  
}

// MARK: - YTPlayerViewDelegate
//
extension SXLaunchDetailsViewController: YTPlayerViewDelegate {
  
  func playerViewPreferredInitialLoading(_ playerView: YTPlayerView) -> UIView? {
    
    let bgView = UIView(frame: playerView.frame)
    bgView.backgroundColor = .darkGray
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    activityIndicator.color = .white
    activityIndicator.startAnimating()
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    bgView.addSubview(activityIndicator)
    
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: bgView.centerXAnchor, constant: 0),
      activityIndicator.centerYAnchor.constraint(equalTo: bgView.centerYAnchor, constant: 0)
    ])
    
    bgView.layoutIfNeeded()
    return bgView
  }
  
}
