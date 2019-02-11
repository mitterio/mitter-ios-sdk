//
//  ApiAuthPlugin.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 13/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Moya

struct ApiAuthPlugin: PluginType {
    let applicationId: String
    let userAuthToken: String
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        
        request.addValue(applicationId, forHTTPHeaderField: Constants.Headers.applicationId)
        
        if (!userAuthToken.isEmpty) {
            request.addValue(userAuthToken, forHTTPHeaderField: Constants.Headers.userAuthToken)
        }
        
        return request
    }
}
