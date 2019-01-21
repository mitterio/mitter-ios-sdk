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
    case fetchChannelsForUser(userId: String)
    case fetchParticipantsForChannel(channelId: String)
    case addChannel(channel: Channel)
    case removeChannel(channelId: String)
}

extension ChannelApiService: TargetType {
    var baseURL: URL {
        return URL(string: Constants.Urls.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .fetchChannel(let channelId):
            return "/v1/channels/\(channelId)"
        case .fetchChannelsForUser(let userId):
            return "/v1/users/\(userId)/channels"
        case .fetchParticipantsForChannel(let channelId):
            return "/v1/channels/\(channelId)/participants"
        case .addChannel:
            return "/v1/channels"
        case .removeChannel(let channelId):
            return "/v1/channels/\(channelId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchChannel, .fetchChannelsForUser, .fetchParticipantsForChannel:
            return .get
        case .addChannel:
            return .post
        case .removeChannel:
            return .delete
        }
    }
    
    var sampleData: Data {
        return "Test".utf8Encoded
    }
    
    var task: Task {
        switch self {
        case .fetchChannel:
            return .requestPlain
        case .fetchChannelsForUser:
            return .requestPlain
        case .fetchParticipantsForChannel:
            return .requestPlain
        case .addChannel(let channel):
            let requestParams = try! wrapModel(channel)
            return .requestParameters(parameters: requestParams, encoding: JSONEncoding.default)
        case .removeChannel:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": Constants.ContentType.json
        ]
    }
    
    var validationType: ValidationType {
        switch self {
        case .fetchChannel, .fetchChannelsForUser, .fetchParticipantsForChannel, .addChannel, .removeChannel:
            return .successCodes
        }
    }
}

private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
