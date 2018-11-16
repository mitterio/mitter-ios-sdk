//
//  Message.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 16/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct Message: Mappable {
    public let messageId: String
    public let internalId: String?
    public let messageType: StandardMessageType
    public let payloadType: String
    public let senderId: Identifiable<User>
    public let textPayload: String
    public let messageData: [MessageDatum]
    
    public init(map: Mapper) throws {
        <#code#>
    }
}
