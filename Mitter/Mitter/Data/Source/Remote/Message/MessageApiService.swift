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
    case fetchMessagesInChannel(channelId: String)
    case fetchMessage(messageId: String)
    case fetchTimelineEventsForMessages(channelId: String, messageIds: String, eventTypeFilter: String)
    case addMessageToChannel(channelId: String, message: Message)
    case addMultipartMessageToChannel(channelId: String, message: Message, file: URL)
    case addTimelineEventsToMessage(channelId: String, messageId: String, timelineEvent: TimelineEvent)
    case removeMessagesFromChannel(channelId: String, messageIds: String)
}

extension MessageApiService: TargetType {
    var baseURL: URL {
        return URL(string: Mitter.mitterApiEndpoint)!
    }
    
    var path: String {
        switch self {
        case .fetchMessagesInChannel(let channelId):
            return "/v1/channels/\(channelId)/messages"
        case .fetchMessage(let messageId):
            return "/v1/messages/\(messageId)"
        case let .fetchTimelineEventsForMessages(channelId, messageIds, _):
            return "/v1/channels/\(channelId)/messages/\(messageIds)/timeline"
        case .addMessageToChannel(let channelId, _):
            return "/v1/channels/\(channelId)/messages"
        case .addMultipartMessageToChannel(let channelId, _, _):
            return "/v1/channels/\(channelId)/messages"
        case let .addTimelineEventsToMessage(channelId, messageId, _):
            return "/v1/channels/\(channelId)/messages/\(messageId)/timeline"
        case let .removeMessagesFromChannel(channelId, messageIds):
            return "/v1/channels/\(channelId)/messages/\(messageIds)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMessagesInChannel, .fetchMessage, .fetchTimelineEventsForMessages:
            return .get
        case .addMessageToChannel, .addMultipartMessageToChannel, .addTimelineEventsToMessage:
            return .post
        case .removeMessagesFromChannel:
            return .delete
        }
    }
    
    var sampleData: Data {
        return "Test".utf8Encoded
    }
    
    var task: Task {
        switch self {
        case .fetchMessagesInChannel:
            return .requestPlain
        case .fetchMessage:
            return .requestPlain
        case .fetchTimelineEventsForMessages(_, _, let eventTypeFilter):
            let queryParams = [Constants.Keys.eventTypeFilter : eventTypeFilter]
            return .requestParameters(parameters: queryParams, encoding: URLEncoding.queryString)
        case .addMessageToChannel(_, let message):
            let requestParams = try! wrapModel(message)
            return .requestParameters(parameters: requestParams, encoding: JSONEncoding.default)
        case let .addMultipartMessageToChannel(_, message, file):
            let requestBody = try! wrapModel(message) as Data
            let mimeType = MimeType(url: file)
            
            let requestBodyPart = MultipartFormData(
                provider: .data(requestBody),
                name: Constants.Keys.requestBody,
                mimeType: Constants.ContentType.json
            )
            let filePart = MultipartFormData(provider: .file(file), name: "name", fileName: "image", mimeType: mimeType.value)
            let multipartData = [requestBodyPart, filePart]
            
            return .uploadMultipart(multipartData)
        case .addTimelineEventsToMessage(_ , _, let timelineEvent):
            let requestParams = try! wrapModel(timelineEvent)
            return .requestParameters(parameters: requestParams, encoding: JSONEncoding.default)
        case .removeMessagesFromChannel:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .addMessageToChannel, .addMultipartMessageToChannel, .addTimelineEventsToMessage, .removeMessagesFromChannel:
            return [
                "Content-Type": Constants.ContentType.json
            ]
        default:
            return [:]
        }
    }
    
    var validationType: ValidationType {
        switch self {
        case .fetchMessagesInChannel,
             .fetchMessage,
             .fetchTimelineEventsForMessages,
             .addMessageToChannel,
             .addMultipartMessageToChannel,
             .addTimelineEventsToMessage,
             .removeMessagesFromChannel:
            return .successCodes
        }
    }
}

private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
