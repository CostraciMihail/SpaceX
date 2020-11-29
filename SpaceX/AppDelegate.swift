//
//  AppDelegate.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/28/20.
//

import UIKit
import Kingfisher

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    setUpKingfisherCache()
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }

  // MARK: - Helpers
  //
  func setUpKingfisherCache() {
    
    let cache = ImageCache.default
    // Limit memory cache size to 300 MB.
    cache.memoryStorage.config.totalCostLimit = 300 * 1024 * 1024

    // Limit memory cache to hold 150 images at most.
    cache.memoryStorage.config.countLimit = 150
    
    // Limit disk cache size to 1 GB.
    cache.diskStorage.config.sizeLimit = 1000 * 1024 * 1024
    
    // Memory image expires after 10 minutes.
    cache.memoryStorage.config.expiration = .seconds(600)
  }
  
}

