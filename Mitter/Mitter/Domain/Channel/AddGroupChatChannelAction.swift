//
//  AddGroupChatChannelAction.swift
//  Mitter
//
//  Created by Rahul Chowdhury on 27/11/18.
//  Copyright © 2018 Chronosphere Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import RxSwift

class AddGroupChatChannelAction: UniParamAction {
    private let channelRepository: ChannelRepository
    
    init(channelRepository: ChannelRepository) {
        self.channelRepository = channelRepository
    }
    
    func execute(t: [Participant]) -> PrimitiveSequence<SingleTrait, Identifiable<Channel>> {
        let channelParticipationList = convertToChannelParticipationList(participants: t)
        
        let channel = Channel(
            channelId: UUID().uuidString,
            defaultRuleSet: StandardRuleSetNames.GroupChat,
            participation: channelParticipationList
        )
        
        return channelRepository.addChannel(channel: channel)
    }
}
