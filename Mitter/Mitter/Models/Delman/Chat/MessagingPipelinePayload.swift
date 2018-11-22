//
//  MessagingPipelinePayload.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 20/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct MessagingPipelinePayload {
    let type: String
    let message: Message?
    let channelId: Identifiable<Channel>?
    let channel: Channel?
    let timelineEvent: TimelineEvent?
    let messageId: Identifiable<Message>?
    let participantId: Identifiable<User>?
    let newStatus: ParticipationStatus?
    let oldStatus: ParticipationStatus?
    public let globalPipelinePayloadId: String
}

extension MessagingPipelinePayload: Mappable {
    public init(map: Mapper) throws {
        type = try map.from("@type")
        message = map.optionalFrom("message")
        channelId = map.optionalFrom("channelId")
        channel = map.optionalFrom("channel")
        timelineEvent = map.optionalFrom("timelineEvent")
        messageId = map.optionalFrom("messageId")
        participantId = map.optionalFrom("participantId")
        newStatus = map.optionalFrom("newStatus")
        oldStatus = map.optionalFrom("oldStatus")
        globalPipelinePayloadId = try map.from("globalPipelinePayloadId")
    }
}
