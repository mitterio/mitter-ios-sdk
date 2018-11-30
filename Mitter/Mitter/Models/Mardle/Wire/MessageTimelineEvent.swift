//
//  MessageTimelineEvent.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 29/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct MessageTimelineEvent {
    public let messageId: Identifiable<Message>
    public let timelineEvent: TimelineEvent
    public let channelId: Identifiable<Channel>?
}

extension MessageTimelineEvent: Mappable {
    public init(map: Mapper) throws {
        messageId = try map.from("messageId")
        timelineEvent = try map.from("timelineEvent")
        channelId = map.optionalFrom("channelId")
    }
}
