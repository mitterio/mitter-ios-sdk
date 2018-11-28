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
    case addMessageToChannel(channelId: String, message: Message)
    case addMultipartMessageToChannel(channelId: String, requestBody: Data, file: URL)
}

extension MessageApiService: TargetType {
    var baseURL: URL {
        return URL(string: Constants.Urls.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .fetchMessagesInChannel(let channelId):
            return "/v1/channels/\(channelId)/messages"
        case .fetchMessage(let messageId):
            return "/v1/messages/\(messageId)"
        case .addMessageToChannel(let channelId, _):
            return "/v1/channels/\(channelId)/messages"
        case .addMultipartMessageToChannel(let channelId, _, _):
            return "/v1/channels/\(channelId)/messages"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMessagesInChannel, .fetchMessage:
            return .get
        case .addMessageToChannel, .addMultipartMessageToChannel:
            return .post
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
        case .addMessageToChannel(_, let message):
            let requestParams = try! wrapModel(message)
            return .requestParameters(parameters: requestParams, encoding: JSONEncoding.default)
        case let .addMultipartMessageToChannel(_, requestBody, file):
            let requestBodyPart = MultipartFormData(provider: .data(requestBody), name: "io.mitter.wire.requestbody", mimeType: "application/json")
            let filePart = MultipartFormData(provider: .file(file), name: "name", fileName: "image", mimeType: "image/jpg")
            let multipartData = [requestBodyPart, filePart]
            
            return .uploadMultipart(multipartData)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    var validationType: ValidationType {
        switch self {
        case .fetchMessagesInChannel, .fetchMessage, .addMessageToChannel, .addMultipartMessageToChannel:
            return .successCodes
        }
    }
}

private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
