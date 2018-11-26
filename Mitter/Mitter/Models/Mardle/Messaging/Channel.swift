//
//  Channel.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 21/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import Mapper

public struct Channel {
    public let channelId: String
    public let defaultRuleSet: String
    public let participation: [ChannelParticipation]?
    public let systemChannel: Bool
    public let appliedAcls: AppliedAclList?
    public let entityMetadata: EntityMetadata?
    public let entityProfile: EntityProfile<Channel>?
    public let timelineEvents: [TimelineEvent]?
    
    init(
        channelId: String,
        defaultRuleSet: String,
        participation: [ChannelParticipation]? = [ChannelParticipation](),
        systemChannel: Bool = false,
        appliedAcls: AppliedAclList? = nil,
        entityMetadata: EntityMetadata? = nil,
        entityProfile: EntityProfile<Channel>? = nil,
        timelineEvents: [TimelineEvent]? = nil
        ) {
        self.channelId = channelId
        self.defaultRuleSet = defaultRuleSet
        self.participation = participation
        self.systemChannel = systemChannel
        self.appliedAcls = appliedAcls
        self.entityMetadata = entityMetadata
        self.entityProfile = entityProfile
        self.timelineEvents = timelineEvents
    }
}

extension Channel: Mappable {
    public init(map: Mapper) throws {
        channelId = try map.from("channelId")
        defaultRuleSet = try map.from("defaultRuleSet")
        participation = map.optionalFrom("participation") ?? [ChannelParticipation]()
        systemChannel = map.optionalFrom("systemChannel") ?? false
        appliedAcls = map.optionalFrom("appliedAcls") ?? AppliedAclList(plusAppliedAcls: [String](), minusAppliedAcls: [String]())
        entityMetadata = map.optionalFrom("entityMetadata")
        entityProfile = map.optionalFrom("entityProfile")
        timelineEvents = map.optionalFrom("timelineEvents") ?? [TimelineEvent]()
    }
}
