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
    case fetchChannels(channelIds: String)
    case fetchChannelsForUser(userId: String)
    case fetchParticipantsForChannel(channelId: String)
    case addChannel(channel: Channel)
    case addParticipantToChannel(channelId: String, channelParticipation: ChannelParticipation)
    case removeChannel(channelId: String)
}

extension ChannelApiService: TargetType {
    var baseURL: URL {
        return URL(string: Mitter.mitterApiEndpoint)!
    }
    
    var path: String {
        switch self {
        case .fetchChannels(let channelIds):
            return "/v1/channels/\(channelIds)"
        case .fetchChannelsForUser(let userId):
            return "/v1/users/\(userId)/channels"
        case .fetchParticipantsForChannel(let channelId):
            return "/v1/channels/\(channelId)/participants"
        case .addChannel:
            return "/v1/channels"
        case .addParticipantToChannel(let channelId, _):
            return "/v1/channels/\(channelId)/participants"
        case .removeChannel(let channelId):
            return "/v1/channels/\(channelId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchChannels, .fetchChannelsForUser, .fetchParticipantsForChannel:
            return .get
        case .addChannel, .addParticipantToChannel:
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
        case .fetchChannels:
            return .requestPlain
        case .fetchChannelsForUser:
            return .requestPlain
        case .fetchParticipantsForChannel:
            return .requestPlain
        case .addChannel(let channel):
            let requestParams = try! wrapModel(channel)
            return .requestParameters(parameters: requestParams, encoding: JSONEncoding.default)
        case .addParticipantToChannel(_, let channelParticipation):
            let requestParams = try! wrapModel(channelParticipation)
            return .requestParameters(parameters: requestParams, encoding: JSONEncoding.default)
        case .removeChannel:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .addChannel, .addParticipantToChannel, .removeChannel:
            return [
                "Content-Type": Constants.ContentType.json
            ]
        default:
            return [:]
        }
    }
    
    var validationType: ValidationType {
        switch self {
        case .fetchChannels,
             .fetchChannelsForUser,
             .fetchParticipantsForChannel,
             .addChannel,
             .addParticipantToChannel,
             .removeChannel:
            return .successCodes
        }
    }
}

private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
