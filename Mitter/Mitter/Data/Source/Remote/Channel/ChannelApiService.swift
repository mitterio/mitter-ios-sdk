//
//  ChannelApiService.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 26/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Moya

enum ChannelApiService {
    case fetchChannel(channelId: String)
    case addChannel(channel: Channel)
}

extension ChannelApiService: TargetType {
    var baseURL: URL {
        return URL(string: Constants.Urls.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .fetchChannel(let channelId):
            return "/v1/channels/\(channelId)"
        case .addChannel:
            return "/v1/channels"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchChannel:
            return .get
        case .addChannel:
            return .post
        }
    }
    
    var sampleData: Data {
        return "Test".utf8Encoded
    }
    
    var task: Task {
        switch self {
        case .fetchChannel:
            return .requestPlain
        case .addChannel(let channel):
            let requestParams = try! wrapModel(channel)
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
        case .fetchChannel, .addChannel:
            return .successCodes
        }
    }
}

private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
