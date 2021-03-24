//
//  SXAPIClientMock.swift
//  SpaceXTests
//
//  Created by Mihail COSTRACI on 24.03.2021.
//  Copyright © 2021 iOSDeveloper. All rights reserved.
//

import Foundation
import Combine

class SXAPIClientMock: SXErrorReponse, SXAPIClientInterface {
  
  private var urlSesssion: SXURLSessionMock
  
  init(urlSesssion: SXURLSessionMock) {
    self.urlSesssion = urlSesssion
  }
  
  func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<SXAPIClientResponse<T>, SXError> {
    
    debugRequest(request)
    
    return urlSesssion
      .sx_dataTaskPublisher(for: request)
      .tryMap { result -> SXAPIClientResponse<T> in
        
        return try self.processResponse(result, decoder: decoder)
      }.mapError({ error -> SXError in
        
        return SXError.toError(error: error)
      })
      .eraseToAnyPublisher()
  }
  
}
