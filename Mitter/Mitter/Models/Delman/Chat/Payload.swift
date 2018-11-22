//
//  Payload.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 21/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

public enum Payload {
    case NewChannelPayload(Channel)
    case NewMessagePayload(Message, Identifiable<Channel>)
    case NewMessageTimelineEventPayload(TimelineEvent, Identifiable<Message>)
    case NewChannelTimelineEventPayload(TimelineEvent, Identifiable<Channel>)
    case ParticipationChangedEventPayload(
        Identifiable<User>,
        Identifiable<Channel>,
        ParticipationStatus,
        ParticipationStatus
    )
    case Empty
}
