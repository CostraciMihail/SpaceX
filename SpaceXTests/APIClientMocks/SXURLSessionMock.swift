//
//  SXURLSessionMock.swift
//  SpaceXTests
//
//  Created by Mihail COSTRACI on 25.03.2021.
//  Copyright © 2021 iOSDeveloper. All rights reserved.
//

import Foundation
import Combine

class SXURLSessionMock: URLSession {
  
  private var response: HTTPURLResponseMock?
  
  func add(response: HTTPURLResponseMock) {
    self.response = response
  }
  
  public func sx_dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: HTTPURLResponse), SXError> {
    
    return Future<(data: Data, response: HTTPURLResponse), SXError> { promise in
      
      if let response = self.response {
        promise(.success((data: response.bodyData, response: response)))
        
      } else {
        promise(.failure(SXError(code: SXErrorKeys.MOCK_RESPONSE_IS_NOT_SETTED.rawValue)))
      }
      
    }.eraseToAnyPublisher()
  }
}
