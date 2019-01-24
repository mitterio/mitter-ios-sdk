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
    case fetchUsersByLocators(locators: String)
    case setUserPresence(userId: String, presence: Presence)
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
        case .fetchUsersByLocators:
            return "/v1/users"
        case .setUserPresence(let userId, _):
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
        case .fetchUsersByLocators:
            return .get
        case .setUserPresence:
            return .post
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
        case .fetchUsersByLocators(let locators):
            let requestParams = [ Constants.Keys.locators: locators ]
            return .requestParameters(parameters: requestParams, encoding: URLEncoding.queryString)
        case .setUserPresence(_, let presence):
            let requestParams = try! wrapModel(presence)
            return .requestParameters(parameters: requestParams, encoding: JSONEncoding.default)
        case .addUserDeliveryEndpoint(_, let fcmDeliveryEndpoint):
            let requestParams = try! wrapModel(fcmDeliveryEndpoint)
            return .requestParameters(parameters: requestParams, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": Constants.ContentType.json
        ]
    }
    
    var validationType: ValidationType {
        switch self {
        case .fetchUser, .fetchUserPresence, .fetchUsersByLocators, .setUserPresence, .addUserDeliveryEndpoint:
            return .successCodes
        }
    }
}

private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
