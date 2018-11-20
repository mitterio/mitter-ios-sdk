//
//  TimelineEvent.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 16/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper
import Unbox

public struct TimelineEvent: Mappable, Unboxable {
    public let eventId: String
    public let internalId: String?
    public let type: String
    public let eventTimeMs: Int64
    public let subject: Identifiable<User>
    public let auditInfo: AuditInfo?
    
    public init(map: Mapper) throws {
        eventId = try map.from("eventId")
        internalId = map.optionalFrom("internalId")
        type = try map.from("type")
        eventTimeMs = try map.from("eventTimeMs")
        subject = try map.from("subject")
        auditInfo = map.optionalFrom("auditInfo")
    }
    
    public init(unboxer: Unboxer) throws {
        eventId = try unboxer.unbox(key: "eventId")
        internalId = unboxer.unbox(key: "internalId")
        type = try unboxer.unbox(key: "type")
        eventTimeMs = try unboxer.unbox(key: "eventTimeMs")
        subject = try unboxer.unbox(key: "subject")
        auditInfo = unboxer.unbox(key: "auditInfo")
    }
    
    public init(
        eventId: String,
        internalId: String? = nil,
        type: String,
        eventTimeMs: Int64,
        subject: Identifiable<User>,
        auditInfo: AuditInfo? = nil
        ) {
        self.eventId = eventId
        self.internalId = internalId
        self.type = type
        self.eventTimeMs = eventTimeMs
        self.subject = subject
        self.auditInfo = auditInfo
    }
}
