//
//  ChannelParticipation.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 26/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct ChannelParticipation {
    public let participantId: Identifiable<User>
    public let participationStatus: ParticipationStatus
    public let channelId: Identifiable<Channel>?
    public let participant: User?
    public let auditInfo: AuditInfo?
    
    public init(
        participantId: Identifiable<User>,
        participationStatus: ParticipationStatus = ParticipationStatus.Active,
        channelId: Identifiable<Channel>? = nil,
        participant: User? = nil
        ) {
        self.participantId = participantId
        self.participationStatus = participationStatus
        self.channelId = channelId
        self.participant = participant
        self.auditInfo = nil
    }
}

extension ChannelParticipation: Mappable, WrapCustomizable {
    public init(map: Mapper) throws {
        participantId = try map.from("participantId")
        participationStatus = try map.from("participationStatus")
        channelId = map.optionalFrom("channelId")
        participant = map.optionalFrom("participant")
        auditInfo = map.optionalFrom("auditInfo")
    }
    
    public func wrap(context: Any?, dateFormatter: DateFormatter?) -> Any? {
        return [
            "participantId": participantId.domainId,
            "participationStatus": participationStatus.rawValue
        ]
    }
}
