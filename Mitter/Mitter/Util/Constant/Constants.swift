//
//  UserConstants.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 12/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

enum Constants {
    enum Urls {
        static let baseUrl = "https://api.staging.mitter.io"
    }
    enum Headers {
        static let applicationId = "X-Mitter-Application-Id"
        static let userAuthToken = "X-Issued-Mitter-User-Authorization"
    }
    
    enum Users {
        static let userRemoteSource = "UserRemoteSource"
        static let userRepository = "UserRepository"
    }
    
    enum Channels {
        static let channelRemoteSource = "ChannelRemoteSource"
        static let channelRepository = "ChannelRepository"
    }
    
    enum Messages {
        static let messageRemoteSource = "MessageRemoteSource"
        static let messageRepository = "MessageRepository"
    }
    
    enum Keys {
        static let userId = "UserId"
        static let authToken = "AuthToken"
        static let requestBody = "io.mitter.wire.requestbody"
        static let notificationDataType = "cloud-notification"
        static let eventTypeFilter = "eventTypeFilter"
    }
    
    enum ContentType {
        static let json = "application/json"
    }
}
