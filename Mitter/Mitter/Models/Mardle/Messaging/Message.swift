//
//  Message.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 16/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct Message {
    public let messageId: String
    public let internalId: String?
    public let messageType: StandardMessageType
    public let payloadType: String
    public let senderId: Identifiable<User>
    public let textPayload: String
    public let messageData: [MessageDatum]
    public let timelineEvents: [TimelineEvent]
    public let appliedAcls: AppliedAclList
    public let entityMetadata: EntityMetadata?
    public let auditInfo: AuditInfo?
    
    public init(
        messageId: String,
        internalId: String? = nil,
        messageType: StandardMessageType = StandardMessageType.Standard,
        payloadType: String = StandardPayloadTypeNames.TextMessage,
        senderId: Identifiable<User>,
        textPayload: String,
        messageData: [MessageDatum] = [MessageDatum](),
        timelineEvents: [TimelineEvent],
        appliedAcls: AppliedAclList,
        entityMetadata: EntityMetadata? = nil,
        auditInfo: AuditInfo? = nil
        ) {
        self.messageId = messageId
        self.internalId = internalId
        self.messageType = messageType
        self.payloadType = payloadType
        self.senderId = senderId
        self.textPayload = textPayload
        self.messageData = messageData
        self.timelineEvents = timelineEvents
        self.appliedAcls = appliedAcls
        self.entityMetadata = entityMetadata
        self.auditInfo = auditInfo
    }
}

extension Message: Mappable {
    public init(map: Mapper) throws {
        messageId = try map.from("messageId")
        internalId = map.optionalFrom("internalId")
        messageType = map.optionalFrom("messageType") ?? StandardMessageType.Standard
        payloadType = try map.from("payloadType")
        senderId = try map.from("senderId")
        textPayload = try map.from("textPayload")
        messageData = try map.from("messageData")
        timelineEvents = try map.from("timelineEvents")
        appliedAcls = AppliedAclList(plusAppliedAcls: [String](), minusAppliedAcls: [String]())
        entityMetadata = try map.from("entityMetadata")
        auditInfo = map.optionalFrom("auditInfo")
    }
}
