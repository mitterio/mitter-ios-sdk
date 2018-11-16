//
//  MessageApiService.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 16/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Moya

enum MessageApiService {
    case fetchMessage(messageId: String)
}

extension MessageApiService: TargetType {
    var baseURL: URL {
        return URL(string: Constants.Urls.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .fetchMessage(let messageId):
            return "/v1/messages/\(messageId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMessage:
            return .get
        }
    }
    
    var sampleData: Data {
        return "Test".utf8Encoded
    }
    
    var task: Task {
        switch self {
        case .fetchMessage:
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
