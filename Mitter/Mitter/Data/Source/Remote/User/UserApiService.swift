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
    case fetchUser(userId: String)
    case fetchUserPresence(userId: String)
    case addUserDeliveryEndpoint(
        userId: String,
        fcmDeliveryEndpoint: FcmDeliveryEndpoint
    )
}

extension UserApiService: TargetType {
    var baseURL: URL {
        return URL(string: Constants.Urls.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .fetchUser(let userId):
            return "/v1/users/\(userId)"
        case .fetchUserPresence(let userId):
            return "/v1/users/\(userId)/presence"
        case .addUserDeliveryEndpoint(let userId, _):
            return "/v1/users/\(userId)/delivery-endpoints"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchUser:
            return .get
        case .fetchUserPresence:
            return .get
        case .addUserDeliveryEndpoint:
            return .post
        }
    }
    
    var sampleData: Data {
        return "Test".utf8Encoded
    }
    
    var task: Task {
        switch self {
        case .fetchUser:
            return .requestPlain
        case .fetchUserPresence:
            return .requestPlain
        case let .addUserDeliveryEndpoint(_, fcmDeliveryEndpoint):
            let requestParams = try! wrap(fcmDeliveryEndpoint)
            return .requestParameters(parameters: requestParams, encoding: JSONEncoding.default)
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
