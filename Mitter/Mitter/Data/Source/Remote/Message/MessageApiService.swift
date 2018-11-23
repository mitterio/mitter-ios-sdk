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
    case addMessageToChannel(channelId: String, message: Message)
}

extension MessageApiService: TargetType {
    var baseURL: URL {
        return URL(string: Constants.Urls.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .fetchMessage(let messageId):
            return "/v1/messages/\(messageId)"
        case .addMessageToChannel(let channelId, _):
            return "/v1/channels/\(channelId)/messages"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMessage:
            return .get
        case .addMessageToChannel:
            return .post
        }
    }
    
    var sampleData: Data {
        return "Test".utf8Encoded
    }
    
    var task: Task {
        switch self {
        case .fetchMessage:
            return .requestPlain
        case .addMessageToChannel(_, let message):
            let requestParams = try! wrapModel(message)
            return .requestParameters(parameters: requestParams, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    var validationType: ValidationType {
        switch self {
        case .fetchMessage, .addMessageToChannel:
            return .successCodes
        }
    }
}

private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
