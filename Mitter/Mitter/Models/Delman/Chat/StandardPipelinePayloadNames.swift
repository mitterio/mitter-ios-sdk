//
//  StandardPipelinePayloadNames.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 20/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

enum StandardPipelinePayloadNames {
    static let NewChannelPayload : String = "new-channel-payload"
    static let NewMessagePayload : String = "new-message-payload"
    
    static let NewMessageTimelineEventPayload : String = "new-message-timeline-event-payload"
    static let NewChannelTimelineEventPayload : String = "new-channel-timeline-event-payload"
    
    static let ParticipationChangedEventPayload : String = "participation-changed-event-payload"
    static let ChannelStreamData : String = "stream-data"
    
    static let PipelineControlPayload : String = "pipeline-control-payload"
}
