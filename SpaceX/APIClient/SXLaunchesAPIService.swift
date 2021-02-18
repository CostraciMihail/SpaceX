//
//  SXCandidatesAPIService.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/29/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation
import Combine

/// SXLaunchesAPIServiceInterface
protocol SXLaunchesAPIServiceInterface {
  
  func getAllPastLaunches() -> AnyPublisher<[SXLaunchModel], SXError>
}

/// SXLaunchesAPIService
class SXLaunchesAPIService: SXLaunchesAPIServiceInterface {
  
  var client = SXAPIClient()
  
  /// Loading all past list of launches 
  /// - Returns: publisher with decoded data from JSON
  func getAllPastLaunches() -> AnyPublisher<[SXLaunchModel], SXError> {
    
    let service = SXLaunchesEndpoint.getAllPastLaunches
    let request = URLRequest(service: service)
    return client.run(request)
      .map(\.value)
      .eraseToAnyPublisher()
  }
}
