//
//  SXLaunchesEndpoint.swift
//  SpaceX
//
//  Created by Mihail Costraci on 11/29/20.
//  Copyright © 2020 iOSDeveloper. All rights reserved.
//

import Foundation

/// SXLaunchesEndpoint
enum SXLaunchesEndpoint: SXEndpointProtocol {
    
    case getAllPastLaunches
    
    /// URL path
    var path: String {
        switch self {
        case .getAllPastLaunches: return "/launches/past"
        }
    }
    
    /// Parameter Encoding
    var parameterEncoding: SXParameterEncoding {
        return .json
    }
    
    /// Http Method
    var httpMethod: SXHTTPMethod {
        return .get
    }
    
    /// HTTPTask
    var task: SXHTTPTask {
        
        let parameters: SXParameters? = nil
        
        switch self {
        case .getAllPastLaunches: break;
        }
        
        return .requestParameters(bodyParameters: parameters, urlParameters: nil)
    }

}
