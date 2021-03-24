//
//  SXAPIClient.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/29/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation
import Combine

/// SXAPIClientResponse
struct SXAPIClientResponse<T> {
  let value: T
  let response: URLResponse
}

protocol SXAPIClientInterface {
  func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder) -> AnyPublisher<SXAPIClientResponse<T>, SXError>
}

/// SXAPIClient responsable for making request
struct SXAPIClient: SXAPIClientInterface, SXErrorReponse {
  
  func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<SXAPIClientResponse<T>, SXError> {
    
    debugRequest(request)
    
    return URLSession.shared
      .dataTaskPublisher(for: request)
      .tryMap { result -> SXAPIClientResponse<T> in
        
        return try self.processResponse(result, decoder: decoder)
      }.mapError({ error -> SXError in
        
        return SXError.toError(error: error)
      })
      .eraseToAnyPublisher()
  }
}
