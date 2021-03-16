//
//  SX_RxSXLaunchesAPIService.swift
//  SpaceX
//
//  Created by Mihail COSTRACI on 16.03.2021.
//  Copyright © 2021 iOSDeveloper. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol SX_RxLaunchesAPIServiceInterface {
  
  func getAllPastLaunches() -> Observable<[SXLaunchModel]>
}

class SX_RxLaunchesAPIService: SX_RxLaunchesAPIServiceInterface {
  
  let apiClient = SXAPIClient()
  
  func getAllPastLaunches() -> Observable<[SXLaunchModel]> {
    
    let service = SXLaunchesEndpoint.getAllPastLaunches
    let urlRequest = URLRequest(service: service)
    return apiClient.rx_run(urlRequest).map({$0.value})
  }
  
}

#if canImport(RxSwift)

protocol SX_RxReponse {
  
  func rx_run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder) -> Observable<SXAPIClientResponse<T>>
}

extension SXAPIClient: SX_RxReponse {
  
  func rx_run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> Observable<SXAPIClientResponse<T>> {
    
    debugRequest(request)
    
    return URLSession.shared.rx.response(request: request)
      .map { (arg0) -> SXAPIClientResponse<T> in
        return try self.processResponse((arg0.data, arg0.response), decoder: decoder)
      }
  }
}

#endif
