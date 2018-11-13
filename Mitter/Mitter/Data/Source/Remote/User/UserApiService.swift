//
//  UserApiService.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 06/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Moya

enum UserApiService {
    case getUser(userId: String)
}

extension UserApiService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.mitter.io")!
    }
    
    var path: String {
        switch self {
        case .getUser(let userId):
            return "/v1/users/\(userId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUser:
            return .get
        }
    }
    
    var sampleData: Data {
        return "Test".utf8Encoded
    }
    
    var task: Task {
        switch self {
        case .getUser:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}

private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
