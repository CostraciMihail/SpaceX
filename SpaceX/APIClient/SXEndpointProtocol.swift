//
//  SXEndpointProtocol.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/29/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation

/// SXHTTPMethod
public enum SXHTTPMethod: String {
  
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

public typealias SXHTTPHeaders = [String: String]
public typealias SXParameters = [String: Any]

/// SXHTTPTask
public enum SXHTTPTask {
  
  case request
  case requestParameters(bodyParameters: SXParameters?,
                         urlParameters: SXParameters?)
}

/// SXParameterEncoding
enum SXParameterEncoding {
  case url
  case json
}

/// SXEndpointProtocol
protocol SXEndpointProtocol {
  
  var baseURL: URL { get }
  var path: String { get }
  var parameterEncoding: SXParameterEncoding { get }
  var httpMethod: SXHTTPMethod { get }
  var task: SXHTTPTask { get }
  var headers: SXHTTPHeaders? { get }
}

extension SXEndpointProtocol {
  
  var baseURL: URL {
    URL(string: "https://api.spacexdata.com/v4")!
  }
  
  var headers: SXHTTPHeaders? {
    ["Content-Type" : "application/json"]
  }
}

extension URLComponents {
  
  init(service: SXEndpointProtocol) {
    
    let url = service.baseURL.appendingPathComponent(service.path)
    self.init(url: url, resolvingAgainstBaseURL: false)!
    
    guard case .requestParameters(_, let urlParams) = service.task else { return }
    queryItems = urlParams?.map { URLQueryItem(name: $0, value: String(describing: $1))}
  }
}

extension URLRequest {
  
  init(service: SXEndpointProtocol) {
    
    let component = URLComponents(service: service)
    self.init(url: component.url!)
    
    service.headers?.forEach({ addValue($1, forHTTPHeaderField: $0) })
    self.httpMethod = service.httpMethod.rawValue
    
    guard case .requestParameters(let bodyParams, _) = service.task,
          let parameters = bodyParams else {
      return
    }
    
    httpBody = try? JSONSerialization.data(withJSONObject: parameters)
  }
}
